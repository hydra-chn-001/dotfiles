#!/usr/bin/env python

import json
import re


def parse_gfwlist(gfwlist_text):
    proxy_suffix = []
    proxy_extract = []
    proxy_regex = []

    direct_suffix = []
    direct_extract = []
    direct_regex = []

    for line in gfwlist_text.splitlines():
        line = line.strip()
        if not line or line.startswith("!"):
            continue

        is_whitelist = line.startswith("@@")
        if is_whitelist:
            line = line[2:]

        if line.startswith("||"):
            domain = line[2:]
            target = direct_suffix if is_whitelist else proxy_suffix
            target.append(domain)

        elif line.startswith("|"):
            domain = line.lstrip("|")
            target = direct_extract if is_whitelist else proxy_extract
            target.append(domain)

        elif line.startswith("/"):
            m = re.match(r"^/(.*)/$", line)
            if m:
                target = direct_regex if is_whitelist else proxy_regex
                target.append(m.group(1))

        else:
            target = direct_suffix if is_whitelist else proxy_suffix
            target.append(line)

    return {
        "proxy_suffix": sorted(set(proxy_suffix)),
        "proxy_extract": sorted(set(proxy_extract)),
        "proxy_regex": sorted(set(proxy_regex)),
        "direct_suffix": sorted(set(direct_suffix)),
        "direct_extract": sorted(set(direct_extract)),
        "direct_regex": sorted(set(direct_regex)),
    }


def to_singbox_rules(domain_extract, domain_suffix, domain_regex):
    rules = []
    if domain_extract:
        rules.append({'domain': domain_extract})
    if domain_suffix:
        rules.append({'domain_suffix': domain_suffix})
    if domain_regex:
        rules.append({'domain_regex': domain_regex})
    return {
        'version': 1,
        'rules': rules
    }


if __name__ == "__main__":
    with open('./gfwlist.txt', 'r') as f:
        parsed = parse_gfwlist(f.read())

    singbox_rules = to_singbox_rules(parsed['proxy_extract'], parsed['proxy_suffix'], parsed['proxy_regex'])
    if singbox_rules['rules']:
        with open("gfwlist.json", "w", encoding="utf-8") as f:
            json.dump(singbox_rules, f, indent=2, ensure_ascii=False)

    singbox_rules = to_singbox_rules(parsed['direct_extract'], parsed['direct_suffix'], parsed['direct_regex'])
    if singbox_rules['rules']:
        with open("gfwlist-white.json", "w", encoding="utf-8") as f:
            json.dump(singbox_rules, f, indent=2, ensure_ascii=False)
