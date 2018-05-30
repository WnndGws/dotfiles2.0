#!/bin/zsh

case "$1" in
    --checking)
        pac=$(pacman -Qu | wc -l | tail -n 1)
        aur=$(cower -q -u --timeout=0 | wc -l )
        check=$(( pac + aur ))
        ;;
    --reset)
        check="0"
        ;;
    --test)
        pac="1"
        aur="1"
        check=$((pac + aur))
        ;;
esac


if [[ "$check" != "0" ]]
then
    echo "$pac %{F#5b5b5b}%{F-} $aur"
fi
