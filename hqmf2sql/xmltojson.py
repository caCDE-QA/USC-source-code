import xmltodict
import sys
import json

if __name__ == '__main__':
    buf = sys.stdin.detach()
    dict = xmltodict.parse(buf)
    print(json.dumps(dict, indent=2))

