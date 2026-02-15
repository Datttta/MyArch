#!/bin/bash

bluetoothctl << EOF
info
EOF
read -n1 -s -r -p "Press any key to close..."
