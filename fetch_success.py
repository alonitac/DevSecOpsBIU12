import json

with open('/home/alon/Downloads/runs.json') as f:
    data = json.load(f)['workflow_runs']

data = [d for d in data if d['conclusion'] == 'success']

branches = sorted(set([d['head_branch'] for d in data]))

[print(b) for b in branches]