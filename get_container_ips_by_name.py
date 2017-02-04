#!/usr/bin/env python2.7
import sys
import json

if len(sys.argv) != 2:
    sys.exit(-1)

inp = ""
with sys.stdin as stdin:
    inp = stdin.read()

json = json.loads(inp)
for container_id, container_metadata in json[0]["Containers"].iteritems():
    if container_metadata["Name"].find(sys.argv[1]) != -1:
        print container_metadata["IPv4Address"]

