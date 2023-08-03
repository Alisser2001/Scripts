#!/bin/bash

test -f /usr/sbin/arp-scan

arp_value=$(echo $?)

if test $arp_value == "0"; then
	echo "All dependencies are installed"
	read -p "1. MAC Address  2. IP Address  3. MAC & IP Address: " option
	echo $option
fi
