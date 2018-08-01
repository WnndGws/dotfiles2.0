#!/usr/bin/zsh
## Uses vnStat to check how much I have downloaded today

vnstat --config /home/wynand/.config/vnstat/vnstat.conf --update
daily_dl=$(vnstat --config /home/wynand/.config/vnstat/vnstat.conf --hours | tail -n 1 | awk '{print $10}')

echo "Hourly:  $daily_dl Mb"
