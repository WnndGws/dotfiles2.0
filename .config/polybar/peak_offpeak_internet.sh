#!/usr/bin/zsh
## Parses VNStat into peak and offpeak

vnstat --config /home/wynand/.config/vnstat/vnstat.conf --update -i wlp0s20u3
daily_dl=$(vnstat --config /home/wynand/.config/vnstat/vnstat.conf --hours | tail -n 8)
time_hours=$(bc <<< $(date +"%H")+1)

off_peak=$(echo $daily_dl | sed 's/\ \]\[\ /\n/g' | sort | awk '/^0[0-7]/' | awk '$1 < $'time_hours' {sum += $2} END {print sum}')
# Sed finds the string ' ][ ' and replaces it with a newline
# Sort 00-24
# awk searches for regex lines that start with 0[2-7] which is the off peak hours, then sums the second column

peak=$(echo $daily_dl |  sed 's/\ \]\[\ /\n/g' | sort | awk '/^00|^01|^08|^09|^[1-2][0-9]/'| awk '$1 < '$time_hours' {sum += $2} END {print sum}')

echo "Offpeak:  $off_peak Mb | Peak:  $peak Mb"
