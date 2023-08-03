#!/bin/bash

test -f /usr/sbin/arp-scan

arp_value=$(echo $?)

if test $arp_value == "0"; then
	echo "All dependencies are installed"
	read -p "1. MAC Address  2. IP Address  3. MAC & IP Address: " option
	echo $option
	if test $option == "1"; then
		arp-scan --localnet | grep -A 10 "Starting" | awk 'NF && $2 ~ /^[0-9]/{print $2}' > /dev/null
	fi
	if test $option == "2"; then
		arp-scan --localnet | grep -A 10 "Starting" | awk 'NF && $2 ~ /^[0-9]/{print $1}' > /dev/null
        fi
	if test $option == "3"; then
		arp-scan --localnet | grep -A 10 "Starting" | awk 'NF && $2 ~ /^[0-9]/' > /dev/null
        fi
fi
