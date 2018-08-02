#!/usr/bin/zsh
## Script to output cpu usage


cpu_usage=$(top -b -n2 -p 1 | fgrep "Cpu(s)" | tail -1 | awk -F'id,' -v prefix="$prefix" '{ split($1, vs, ","); v=vs[length(vs)]; sub("%", "", v); printf "%s%.0f", prefix, 100 - v }')

case "$cpu_usage" in 
    #([0-9]) echo "%{u#4E9A06 +u}   $cpu_usage%";;
    #([1-4][0-9]) echo "%{u#4E9A06 +u}  $cpu_usage%";;
    #([5-8][0-9]) echo "%{u#ffb52a +u}  $cpu_usage%";;
    #([9-9][0-9]|100) echo "%{u#cb4b16 +u}  $cpu_usage%";;
    ([0-9]) echo "%{u#555753 +u}   $cpu_usage%";;
    ([1-4][0-9]) echo "%{u#555753 +u}  $cpu_usage%";;
    ([5-8][0-9]) echo "%{u#ffb52a +u}  $cpu_usage%";;
    ([9-9][0-9]|100) echo "%{u#cb4b16 +u}  $cpu_usage%";;
esac

