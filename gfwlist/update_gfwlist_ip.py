#!/usr/bin/env python

import requests
import json


def fetch_cidr_list():
    ipv4_cidr_list = []
    res = requests.get("https://core.telegram.org/resources/cidr.txt")
    res.raise_for_status()
    for line in res.text.splitlines():
        line = line.strip()
        if line and '.' in line:
            ipv4_cidr_list.append(line)
    return {
        'ipv4': ipv4_cidr_list,
        'ipv6': ipv4_cidr_list,
    }


def convert_to_singbox(ip_cidr):
    return {
        "version": 1,
        "rules": [
            {
                "ip_cidr": ip_cidr
            }
        ]
    }


if __name__ == "__main__":
    cidr_list = fetch_cidr_list()
    rules = convert_to_singbox(cidr_list['ipv4'])

    with open("gfwlist-ip.json", "w", encoding="utf-8") as f:
        json.dump(rules, f, indent=2)
