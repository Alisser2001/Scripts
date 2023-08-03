#!/bin/bash

host=$1

ip_regex='^([0-9]{1,3}\.){3}[0-9]{1,3}$'

if [[ $host =~ $ip_regex ]]; then
    echo "Vamos a analizar la IP: $host"
else
    echo "Vamos a analizar la IP: $(nslookup $host | grep "Non-authoritative answer:" -A 2 | tail -n 1 | awk 'NF{print $NF}')"
fi 

ping -c 1 $host > ping.log

for i in $(seq 60 70); do
	if test $(grep ttl=$i ping.log -c) = 1; then
		echo "La máquina es Linux/Unix"
	fi
done

for i in $(seq 100 130); do
        if test $(grep ttl=$i ping.log -c) = 1; then
                echo "La máquina es Windows"
	fi
done

for i in $(seq 250 260); do
        if test $(grep ttl=$i ping.log -c) = 1; then
                echo "La máquina es Solaris/AIX"
        fi
done

rm ping.log
