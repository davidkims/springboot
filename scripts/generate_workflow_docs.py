import os
import yaml

WORKFLOW_DIR = os.path.join('.github', 'workflows')
OUTPUT_DIR = 'workflow_docs'

def load_workflows(path):
    for fname in os.listdir(path):
        if fname.endswith(('.yml', '.yaml')):
            fpath = os.path.join(path, fname)
            with open(fpath, 'r', encoding='utf-8') as f:
                try:
                    # Use BaseLoader so keys like 'on' are not treated as booleans
                    data = yaml.load(f, Loader=yaml.BaseLoader)
                except Exception as e:
                    print(f'Error parsing {fpath}: {e}')
                    data = None
            if data:
                yield fname, data

def main():
    os.makedirs(OUTPUT_DIR, exist_ok=True)
    for fname, data in load_workflows(WORKFLOW_DIR):
        name = data.get('name', 'Unnamed Workflow')
        on_field = data.get('on')
        if isinstance(on_field, dict):
            triggers = ', '.join(on_field.keys())
        elif isinstance(on_field, list):
            triggers = ', '.join(on_field)
        else:
            triggers = str(on_field)
        steps = []
        for job in data.get('jobs', {}).values():
            for step in job.get('steps', []):
                step_name = step.get('name')
                if step_name:
                    steps.append(step_name)
        md_fname = fname.rsplit('.', 1)[0] + '.md'
        out_path = os.path.join(OUTPUT_DIR, md_fname)
        with open(out_path, 'w', encoding='utf-8') as out:
            out.write(f'# {name}\n\n')
            out.write(f'Source: `.github/workflows/{fname}`\n\n')
            out.write(f'**Triggers**: {triggers}\n\n')
            if steps:
                out.write('## Steps\n')
                for s in steps:
                    out.write(f'- {s}\n')
        print(f'Wrote {out_path}')

if __name__ == '__main__':
    main()
