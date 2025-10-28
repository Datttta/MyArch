#!/bin/bash

bluetoothctl << EOF
disconnect
exit
EOF
notify-send "  Device disconnected"
