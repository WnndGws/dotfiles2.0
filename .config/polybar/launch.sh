#!/usr/bin/env sh

# Terminate already running bar instances
killall -9 -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

# Launch polybar
sleep 0.5; polybar -q wyni3 &
polybar -q wyni3_top &
