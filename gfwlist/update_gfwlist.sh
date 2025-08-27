./update_gfwlist.py
[ -f gfwlist.json ] && sing-box rule-set compile gfwlist.json
[ -f gfwlist-cdn.json ] && sing-box rule-set compile gfwlist-cdn.json
[ -f gfwlist-whitelist.json ] && sing-box rule-set compile gfwlist-whitelist.json
[ -f dns_poisioning.json ] && sing-box rule-set compile dns_poisioning.json
