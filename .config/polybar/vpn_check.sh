#!/usr/bin/zsh
## Checks if VPN is running

basedir=$(dirname $(readlink -f "$0"))

#If was connected, and still is
if [ "$(pgrep openvpn)" ] && [[ -f $basedir/.vpn_connected*.ini ]]; then
    country=$(find $basedir -type f -name "*.vpn_connected*" | cut -d"_" -f3 | rev | cut -d"." -f2 | cut -d"_" -f1 | rev)
    colour="%{u#4E9A06 +u}"
    icon=""

#If was not connected, now is
elif [ "$(pgrep openvpn)" ]; then
    country=$(dig +short myip.opendns.com @resolver1.opendns.com | xargs -I{} geoiplookup {} | awk '{print $4}' | rev | cut -c 2- | rev)
    rm -f ./.vpn*.ini
    touch ./.vpn_connected_$country.ini
    colour="%{u#4E9A06 +u}"
    icon=""

#If was connected, not any more
elif [[ -f $basedir/.vpn_connected*.ini ]]; then
    country=$(dig +short myip.opendns.com @resolver1.opendns.com | xargs -I{} geoiplookup {} | awk '{print $4}' | rev | cut -c 2- | rev)
    rm -f ./.vpn*.ini
    touch ./.vpn_disconnected_$country.ini
    colour="%{u#cb4b16 +u}"
    icon=""

#If wasn't connected, still isn't
else
    country=$(find $basedir -type f -name "*.vpn_disconnected*" | cut -d"_" -f3 | rev | cut -d"." -f2 | cut -d"_" -f1 | rev)
    colour="%{u#cb4b16 +u}"
    icon=""
fi

#Echo state
echo $colour$icon "VPN ("$country")"
