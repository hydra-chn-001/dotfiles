: > ipset.save
: > ipset6.save

for geoip_category in cn private;
do
  geoip=$(curl https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/refs/heads/sing/geo/geoip/$geoip_category.json | jq -r '.rules[0].ip_cidr.[]')
  geoip_ipv4=$(echo "$geoip" | grep -v :)
  echo "create geoip_${geoip_category}_ipv4 hash:net family inet hashsize 64 maxelem 65536" >> ipset.save
  for ip in $geoip_ipv4;
  do
    echo "add geoip_${geoip_category}_ipv4 $ip" >> ipset.save
  done

  geoip_ipv6=$(echo "$geoip" | grep :)
  echo "create geoip_${geoip_category}_ipv6 hash:net family inet6 hashsize 64 maxelem 65536" >> ipset_v6.save
  for ip in $geoip_ipv6;
  do
    echo "add geoip_${geoip_category}_ipv6 $ip" >> ipset_v6.save
  done
done
