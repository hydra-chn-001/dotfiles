curl -s https://www.cloudflare.com/ips-v4/ > ~/data/cloudflare-ipv4.txt | grep -Eo '([0-9]+\.){3}[0-9]+/[0-9]+' | jq -Rs '
{
  version: 1,
  rules: [
    { ip_cidr: (split("\n") | map(select(length>0))) }
  ]
}
' > cloudflare-ip.json
sing-box rule-set compile cloudflare-ip.json

curl -s https://api.fastly.com/public-ip-list | jq -r '
{
  version: 1,
  rules: [
    { ip_cidr: .addresses }
  ]
}' > fastly-ip.json
sing-box rule-set compile fastly-ip.json


curl -s https://raw.githubusercontent.com/platformbuilds/Akamai-ASN-and-IPs-List/refs/heads/master/akamai_ip_list.lst | jq -Rs '
{
  version: 1,
  rules: [
    { ip_cidr: (split("\n") | map(select(length>0))) }
  ]
}
' > akamai-ip.json
sing-box rule-set compile akamai-ip.json
