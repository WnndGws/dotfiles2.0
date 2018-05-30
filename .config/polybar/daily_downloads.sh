#!/usr/bin/zsh
## Uses vnStat to check how much I have downloaded today

vnstat --config /home/wynand/.config/vnstat/vnstat.conf --update
daily_dl=$(vnstat --config /home/wynand/.config/vnstat/vnstat.conf --oneline | awk -F ';' '{print $6}')

echo " $daily_dl"
