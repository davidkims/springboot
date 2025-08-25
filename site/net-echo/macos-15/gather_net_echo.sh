#!/usr/bin/env bash
set -Eeuo pipefail
ECHO_ROOT="${ECHO_ROOT:-./net_echo}"
OUT_DIR="${OUT_DIR:-${ECHO_ROOT}/out}"
BIN_DIR="${BIN_DIR:-${ECHO_ROOT}/bin}"
LOG_DIR="${LOG_DIR:-${ECHO_ROOT}/logs}"
ARCHIVE="${ARCHIVE:-${ECHO_ROOT}/net_echo_$(date +%Y%m%d_%H%M%S).tar.gz}"
mkdir -p "$OUT_DIR" "$BIN_DIR" "$LOG_DIR"
echoe(){ echo "[ECHO][$(date +%H:%M:%S)] $*"; }
trap 'rc=$?; echoe "FAILED at: ${BASH_COMMAND} (rc=${rc})"; exit $rc' ERR
check_cmd(){ local c="$1"; if command -v "$c" >/dev/null 2>&1; then
  local v; v="$("$c" --version 2>/dev/null | head -n1 || true)"
  printf "%-18s : %s\n" "$c" "${v:-(no version line)}" | tee -a "${BIN_DIR}/commands.txt"
else printf "%-18s : MISSING\n" "$c" | tee -a "${BIN_DIR}/commands.txt"; fi; }
dump(){ local title="$1"; shift; local out="${OUT_DIR}/${title}.txt"
  echoe "[RUN] $* -> ${out}"; if "$@" >"${out}" 2>&1; then echoe "[OK] ${title}"; else echoe "[WARN] ${title}"; fi; }
copy_file(){ local p="$1" n="${2:-$(basename "$1")}"; [ -f "$p" ] && { echoe "[COPY] $p -> ${OUT_DIR}/${n}"; cp -a "$p" "${OUT_DIR}/${n}"; } || echoe "[MISS] $p"; }

{ echo "DATE: $(date -Is)"; echo "UNAME: $(uname -a)";
  echo; echo "OS RELEASE:"; (cat /etc/os-release 2>/dev/null || sw_vers 2>/dev/null || true); } | tee "${OUT_DIR}/00_system_overview.txt"

for c in ip ifconfig route ss netstat arp iptables ip6tables nft ufw resolvectl systemd-resolve nmcli networksetup scutil ethtool lshw lspci iw iwconfig iwlist nslookup dig host curl wget netplan sysctl; do check_cmd "$c" || true; done

if command -v ip >/dev/null; then
  dump "ip_addr" ip addr; dump "ip_link" ip -d link; dump "ip_neigh" ip neigh
  dump "ip_route" ip route show table all; dump "ip_rule" ip rule show
else command -v ifconfig >/dev/null && dump "ifconfig" ifconfig || true
     command -v route    >/dev/null && dump "route" route -n || true; fi

if command -v ss >/dev/null; then dump "ss_tcp_listen" ss -tlnp; dump "ss_udp_listen" ss -ulnp; dump "ss_summary" ss -s
elif command -v netstat >/dev/null; then dump "netstat_listen" netstat -tulpn; dump "netstat_routes" netstat -rn; fi

command -v arp >/dev/null && dump "arp" arp -an || true
copy_file "/etc/resolv.conf" "resolv.conf"; copy_file "/etc/hosts" "hosts"; copy_file "/etc/nsswitch.conf" "nsswitch.conf"
command -v resolvectl >/dev/null && dump "resolvectl_status" resolvectl status || true
command -v systemd-resolve >/dev/null && dump "systemd_resolve_status" systemd-resolve --status || true
command -v ufw >/dev/null && dump "ufw_status" ufw status verbose || true
command -v iptables  >/dev/null && dump "iptables_save"  sh -c 'iptables -S; iptables -L -v -n' || true
command -v ip6tables >/dev/null && dump "ip6tables_save" sh -c 'ip6tables -S; ip6tables -L -v -n' || true
command -v nft >/dev/null && dump "nft_ruleset" nft list ruleset || true

dump "sysctl_net" sh -c 'sysctl -a 2>/dev/null | grep -E "^(net\.|fs\.ipv4|fs\.ipv6)" || true'
command -v ethtool >/dev/null && { for nic in $(ls /sys/class/net 2>/dev/null | grep -v lo || true); do dump "ethtool_${nic}" ethtool "$nic"; done; }
command -v lspci >/dev/null && dump "lspci_net"  sh -c 'lspci -nn | grep -i -E "net|ether|wireless|wifi"'
command -v lshw  >/dev/null && dump "lshw_net"   sh -c 'lshw -class network -sanitize'
command -v iw >/dev/null && dump "iw_link" iw dev || true
command -v iwconfig >/dev/null && dump "iwconfig" iwconfig || true
command -v iwlist   >/dev/null && dump "iwlist_scan" sh -c 'iwlist scan 2>/dev/null || true'

command -v nmcli >/dev/null && { dump "nmcli_general" nmcli general status; dump "nmcli_dev" nmcli device status; dump "nmcli_conn" nmcli -f NAME,UUID,TYPE,DEVICE connection show; dump "nmcli_dns" nmcli dev show; }
if [[ "$(uname -s)" == "Darwin" ]]; then
  command -v networksetup >/dev/null && dump "networksetup_all" sh -c 'networksetup -listallnetworkservices; for s in $(networksetup -listallnetworkservices | tail -n +2); do echo "=== $s ==="; networksetup -getinfo "$s"; done'
  command -v scutil        >/dev/null && dump "scutil_dns" scutil --dns
fi

[ -d /etc/netplan ] && { dump "netplan_render" sh -c 'ls -al /etc/netplan; echo; (cat /etc/netplan/*.yaml 2>/dev/null || true)'; }
[ -f /etc/network/interfaces ] && cp -a /etc/network/interfaces "${OUT_DIR}/interfaces.legacy" || true

dump "ping_default_gw" sh -c 'gw=$(ip route | awk "/default/ {print \$3; exit}"); [ -n "$gw" ] && (ping -c 2 -W 1 "$gw" || true) || echo "No default gateway"'
for H in 1.1.1.1 8.8.8.8 google.com cloudflare-dns.com; do dump "nslookup_${H//./_}" sh -c "command -v nslookup >/dev/null && nslookup $H || echo nslookup-missing"; done
command -v dig >/dev/null  && dump "dig_resolver_test" sh -c 'dig +short @1.1.1.1 example.com; dig +short example.com' || true
command -v host >/dev/null && dump "host_example" host example.com || true

{ echo "# NET ECHO INDEX ($(date -Is))"; echo; echo "## Directories"; printf "%s\n" "$ECHO_ROOT" "$OUT_DIR" "$BIN_DIR" "$LOG_DIR"; echo; echo "## Files"; find "$OUT_DIR" -type f | sed -e "s|^| - |"; } > "${ECHO_ROOT}/INDEX.md"
echoe "[ARCHIVE] build"
tar -czf "${ARCHIVE}" -C "${ECHO_ROOT}" "out" 2>/dev/null || true
echoe "[DONE] OUT=${OUT_DIR} ARCHIVE=${ARCHIVE}"
