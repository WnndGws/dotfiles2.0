#!/bin/zsh
## Start redshift

redshift -b 1.0:0.8 -l geoclue2 -t 5500:3000 & disown redshift

