#!/usr/bin/zsh
## Adapted from https://gist.github.com/KaliumPuceon/0615e3d6faf3a771c6aa323d0aed0ee2

if pgrep -x "cmus" > /dev/null # is cmus running
then
    START=$(cmus-remote -C status | grep "tag\ title" | head -n 1 | cut -d ' ' -f 3-)
    END=$(cmus-remote -C status | grep "tag\ artist" | head -n 1 | cut -d ' ' -f 3-)
    PLAYING=${START:0:60}" - "${END:0:40}
else
    echo "cmus off"
fi
echo $PLAYING
