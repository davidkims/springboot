import os
from datetime import datetime

EXCLUDE_DIRS = {'.git', '.github'}
EXTENSIONS = {'.py', '.sh', '.rs', '.yml', '.yaml', '.toml', '.md'}


def collect_file_info(root_dir='.'):
    file_info = []
    for root, dirs, files in os.walk(root_dir):
        dirs[:] = [d for d in dirs if d not in EXCLUDE_DIRS]
        for fname in files:
            if fname.startswith('.'):
                continue
            path = os.path.join(root, fname)
            if os.path.splitext(fname)[1] in EXTENSIONS:
                try:
                    with open(path, 'r', encoding='utf-8', errors='ignore') as fp:
                        lines = fp.readlines()
                except Exception:
                    lines = []
                snippet = ''.join(lines[:5])
                file_info.append((path, len(lines), snippet))
    return sorted(file_info)


def generate_blog(file_info, output_path='BLOG.md'):
    with open(output_path, 'w', encoding='utf-8') as out:
        out.write('# 코드 설명 블로그\n\n')
        out.write(f'생성 시각: {datetime.now().strftime("%Y-%m-%d %H:%M:%S")}\n\n')
        out.write('GitHub Actions를 통해 자동 생성된 현재 코드 베이스 요약입니다.\n\n')
        for path, length, snippet in file_info:
            out.write(f'## 파일: `{path}` ({length} lines)\n\n')
            ext = os.path.splitext(path)[1].lstrip('.')
            out.write('```' + ext + '\n')
            out.write(snippet)
            if not snippet.endswith('\n'):
                out.write('\n')
            out.write('```\n\n')
    print(f'Blog written to {output_path}')


if __name__ == '__main__':
    info = collect_file_info('.')
    generate_blog(info)
