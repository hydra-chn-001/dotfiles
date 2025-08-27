./update_gfwlist.py
[ -f gfwlist.json ] && sing-box rule-set compile gfwlist.json
[ -f gfwlist-whitelist.json ] && sing-box rule-set compile gfwlist-whitelist.json

./update_gfwlist.py
[ -f gfwlist.json ] && sing-box rule-set compile gfwlist.json
[ -f gfwlist-whitelist.json ] && sing-box rule-set compile gfwlist-whitelist.json
