curl -s https://raw.githubusercontent.com/platformbuilds/Akamai-ASN-and-IPs-List/refs/heads/master/akamai_ip_list.lst | jq -Rs '
{
  version: 1,
  rules: [
    { ip_cidr: (split("\n") | map(select(length>0))) }
  ]
}
' > akamai-ip.json
sing-box rule-set compile akamai-ip.json
