#!/bin/bash

export internet_connected=0
export red_color="\033[31m"
export green_color="\033[32m"
export restor_term="\033[0m"

check_essid(){
	if iwlist ${interface_name} scan | grep -q ${network_essid}
	then
		return 0
	else
		echo -e "${red_color}Your enter no exist essid!${restore_term}"
		exit 0
	fi
}

timeout() {
	local cmd_pid sleep_pid retval
	(shift; "$@") &
	cmd_pid=$!
	(sleep "$1"; kill "$cmd_pid" 2>/dev/null) &
	sleep_pid=$!
	wait "$cmd_pid"
	retval=$?
	kill "$sleep_pid" 2>/dev/null
	return "$retval"
}

check_internet_connection() {
	while [ ${internet_connected} == 0 ]
	do
		if curl -Is https://www.google.com | head -n 1 | grep -q '200'
		then
        		export internet_connected=1
        		break
    		else
			continue
		fi
	done
}

echo "Run this script form root!"

read -p "Run command iwconfig and enter interface name: " interface_name
read -p "Enter your ESSID: " network_essid
read -p "Enter password for your network: " network_password

ifconfig ${interface_name} up

check_essid

wpa_passphrase ${network_essid} ${network_password} | tee /etc/wpa_supplicant.conf

if wpa_supplicant -B -c /etc/wpa_supplicant.conf -i ${interface_name} | grep -q "Could not read interface"
then
	echo -e "${red_color}Your enter wrong interface name!${restore_term}"
	exit 0
fi

timeout 10 check_internet_connection

if [ ${internet_connected} -eq 0 ] 
then
	echo -e "${green_color}WiFi connected!${restore_term}"
else
	echo -e "${red_color}No internet connection!${restore_term}"
fi
