#!/bin/bash

test -f /usr/bin/nmap

if [ "$(echo $?)" == "0" ]; then
	echo "Nmap está instalado"
else
	echo "Nmap no está instalado" && echo "Instalando..." && sudo apt update > /dev/null && sudo apt install nmap -y > /dev/null
	echo "Nmap está instalado"
fi

ip=$1
ip_regex='^([0-9]{1,3}\.){3}[0-9]{1,3}$'

if [[ $ip =~ $ip_regex ]]; then
    echo "Vamos a analizar la IP: $ip"
else
    echo "Vamos a analizar la IP: $(nslookup $ip | grep "Non-authoritative answer:" -A 2 | tail -n 1 | awk 'NF{print $NF}')"
fi

ping -c 1 $ip > ping.log

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

nmap -p- -sV -sC --open -sS -n -Pn $ip -oN scan
