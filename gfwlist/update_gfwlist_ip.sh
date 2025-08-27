./update_gfwlist_ip.py
[ -f gfwlist-ip.json ] && sing-box rule-set compile gfwlist-ip.json
