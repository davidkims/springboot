use std::fs::File;
use std::io::Write;
use std::path::Path;

fn main() -> std::io::Result<()> {
    let base = Path::new("../workflow");

    let mut sys_file = File::create(base.join("system/app.log"))?;
    writeln!(sys_file, "애플리케이션 로그")?;

    let mut disk_file = File::create(base.join("disk/disk_usage.txt"))?;
    writeln!(disk_file, "디스크 사용량 정보")?;

    let mut container_file = File::create(base.join("container/container.log"))?;
    writeln!(container_file, "컨테이너 로그")?;

    let mut image_file = File::create(base.join("image/image_info.txt"))?;
    writeln!(image_file, "이미지 메타데이터")?;

    Ok(())
}
