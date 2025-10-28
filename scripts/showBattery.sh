#!/bin/bash

bluetoothctl << EOF
info
EOF
read -p "Press enter to close..."

