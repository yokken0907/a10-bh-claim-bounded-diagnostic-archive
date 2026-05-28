#!/usr/bin/env python3
import csv, hashlib, json, pathlib, sys
root = pathlib.Path(__file__).resolve().parents[1]
manifest = root / 'MANIFEST.csv'
if not manifest.exists():
    print('FAIL-SOURCE-MANIFEST-VERIFICATION: missing MANIFEST.csv')
    sys.exit(1)
errors=[]
count=0
with manifest.open(newline='', encoding='utf-8') as f:
    reader=csv.DictReader(f)
    for row in reader:
        rel=row['path']
        path=root/rel
        if not path.exists():
            errors.append(f'missing: {rel}')
            continue
        data=path.read_bytes()
        sha=hashlib.sha256(data).hexdigest()
        size=str(len(data))
        if sha != row['sha256']:
            errors.append(f'sha256 mismatch: {rel}')
        if size != str(row['size_bytes']):
            errors.append(f'size mismatch: {rel}')
        count += 1
if errors:
    print('FAIL-SOURCE-MANIFEST-VERIFICATION')
    for e in errors:
        print(e)
    sys.exit(1)
print('PASS-SOURCE-MANIFEST-VERIFICATION')
print(f'verified_file_count: {count}')
