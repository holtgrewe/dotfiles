#!/bin/bash

rtt=$(ping -c 1 -W 2 heise.de | grep time= | sed -e 's/.*time=//g' 2>/dev/null)

if [[ "$?" == 0 ]]; then
    echo $rtt
else
    echo "N/A"
fi
