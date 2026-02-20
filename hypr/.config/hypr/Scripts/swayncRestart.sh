#!/bin/bash

killall swaync
exec swaync &

sleep 0.5
notify-send "Swaync restarted"
