(cd geolite2 && unzip GeoLite2-Country-CSV.zip && mv GeoLite2-Country-CSV_*/* . && rm -rf GeoLite2-Country-CSV_*)
(cd geolite2 && unzip GeoLite2-ASN-CSV.zip && mv GeoLite2-ASN-CSV_*/* . && rm -rf GeoLite2-ASN-CSV_*)

mkdir output
(cd geolite2 && tar xf GeoLite2-Country.tar.gz && mv GeoLite2-Country_*/* ../output && rm -rf GeoLite2-Country_*)
(cd geolite2 && tar xf GeoLite2-ASN.tar.gz && mv GeoLite2-ASN_*/* ../output && rm -rf GeoLite2-ASN-_*)

type geoip || go install github.com/Loyalsoldier/geoip@latest
geoip convert

type geo || go install github.com/metacubex/geo/cmd/geo@latest
(cd output && geo convert ip -i v2ray -o meta -f geoip.metadb ./geoip.dat)
mv output/geoip.metadb .
