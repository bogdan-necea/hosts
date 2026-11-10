#!/bin/bash

check_ip() {
	dns_ip=$(nslookup $1 $3 | grep -A1 "Name:" | grep "Address:" | awk '{print $2}')
	if [ -n "$dns_ip" ] && [ "$2" != "$dns_ip" ]; then
		echo "$1 in /etc/hosts!"
	fi
}

cat /etc/hosts | grep -v '^#' | grep -v '^$' | while read ip hostname aliases; do
	check_ip "$hostname" "$ip" "8.8.8.8"
done
