./update_gfwlist.py *.txt

for f in *.json; do
 sing-box rule-set compile $f
done
