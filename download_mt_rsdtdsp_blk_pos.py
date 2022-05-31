#!/usr/bin/env python

import os
import os.path
import urllib.request
from ckanapi import RemoteCKAN
ua = 'ckanapi/1.0'

digital_cat = RemoteCKAN('https://registry-catalog.registries.digital.go.jp')

# print(f"Search results count: {packages['count']}")
# print(f"Result array lengeth: {len(packages['results'])}")

packages = []

cursor = 0
while True:
  p = digital_cat.action.package_search(fq='+groups:g2-000007', rows=100, start=cursor)
  if len(p['results']) == 0:
    break

  packages = packages + p['results']

  cursor += 100

print(f"Loaded metadata for all packages: {len(packages)}")

os.makedirs('./out', exist_ok=True)
for package in packages:
  print(f"Downloading resources for: {package['title']}")
  for resource in package['resources']:
    print(f"  {resource['name']}")
    out_dir = os.path.join('./out', os.path.dirname(resource['name']))
    os.makedirs(out_dir, exist_ok=True)
    filename = os.path.basename(resource['name'])
    urllib.request.urlretrieve(
      resource['url'],
      os.path.join(out_dir, filename)
    )
