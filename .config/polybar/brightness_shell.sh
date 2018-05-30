#!/bin/sh

brightness_level=$(brightnessctl g)
brightness_max=$(brightnessctl m)

brightness_percent=$(( $brightness_level * 100 / $brightness_max ))

if [ "$brightness_percent" -gt 85 ]; then
    icon="🌑"
elif [ "$brightness_percent" -gt 60 ]; then
    icon="🌒"
elif [ "$brightness_percent" -gt 35 ]; then
    icon="🌓"
elif [ "$brightness_percent" -gt 10 ]; then
    icon="🌔"
else
    icon="🌕"
fi

echo "%{u#555753 +u}$icon $brightness_percent%"

