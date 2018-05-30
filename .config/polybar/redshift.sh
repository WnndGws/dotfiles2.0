#!/bin/bash

# Specifying the icon(s) in the script
# This allows us to change its appearance conditionally
icon="  "

pgrep -x redshift &> /dev/null
if [[ $? -eq 0 ]]; then
    temp=$(redshift -b 1.0:0.8 -l -33:117 -t 5500:3000 -p 2>/dev/null | grep temp | cut -d' ' -f3)
    temp=${temp//K/}
fi

# OPTIONAL: Append ' ${temp}K' after $icon
if [[ -z $temp ]]; then
    echo "%{F#65737E}$icon Off"       # Greyed out (not running)
elif [[ $temp -ge 5000 ]]; then
    echo "%{u#3465A4 +u}%{F#3465A4}$icon%{F#D3D7CF} Day "       # Blue
elif [[ $temp -ge 4000 ]]; then
    echo "%{u#FFB52A +u}%{F#FFB52A}$icon%{F#D3D7CF} Night "       # Yellow
else
    echo "%{u#BD2c40 +u}%{F#BD2c40}$icon%{F#D3D7CF} Night "       # Red
fi
