#!/usr/bin/zsh
## Checks my calendar for whatever the next even in it is

time_now=$(date +%T)
next_event=$(gcalcli agenda $time_now | awk '{if ($3 ~ /:/) print substr($0, index($0,$3))}' | head -n 1)
# awk checks if 3rd column has a : character in it, then only prints from 3rd column onwards
echo $next_event
