#!/bin/bash

powered=$(echo "show" | bluetoothctl | grep "Powered" | cut -d " " -f 2)

if [[ $powered == yes ]]
then
	bluetoothctl power off
else
	bluetoothctl power on
fi
