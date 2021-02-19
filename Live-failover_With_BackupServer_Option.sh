#!/bin/bash

clear screen

# Author: Joel Tricanji Version 1.000   Date: 28.03.2018

echo "################## LIVE WEBSITE FAILOVER  #####################"
echo

# Variables to declare
int_cfg_path="/etc/sysconfig/network-scripts"
failover_file="FAILOVER-ifcfg-eth1"
orig_file="ORIG-ifcfg-eth1"
nic_card=eth1
online_ip="136.153.26.16"

# Beging of Script
# Check for arguments

	if [ -z "$1" ]
		then

	echo "		No argument has been supplied"
	echo "		Example: sudo failover.sh offline "
	echo
echo "###############################################################"
	exit
	fi
# Verify if online IP is responding



# Excute the task Offline / Online

case $1 in
    online )
		echo "		Bringging Backup Server to Online mode"

		ifdown $nic_card > /dev/null 2>&1
		sleep 5
		cat $int_cfg_path/$failover_file > $int_cfg_path/ifcfg-$nic_card
		sleep 5
		ifup $nic_card > /dev/null 2>&1
		sleep 10
		if [ `ip a | grep $online_ip |wc -l` -ne "1" ] 
			then

		echo " ### WARNING ### - SCRIPT ERROR FOLLOW MANUAL COMMAND - ifdown $nic_card"
			else
		
		echo
		echo " # INFO # - SCRIPT EXECUTED WITH SUCCESS - SERVER IS NOW ONLINE"
		fi

		;;		

    offline )
		echo "		Bringging Backup Server to Offline mode"

	 	ifdown $nic_cardi > /dev/null 2>&1
		sleep 5
		cat $int_cfg_path/$orig_file > $int_cfg_path/ifcfg-$nic_card
		sleep 5
		ifup $nic_card > /dev/null 2>&1
		if [ `ip a | grep $online_ip` ]
                        then

                echo " ### WARNING ### - SCRIPT ERROR FOLLOW MANUAL COMMAND - ifdown $nic_card"
                        else

                echo
                echo " # INFO # - SCRIPT EXECUTED WITH SUCCESS - SERVER IS NOW OFFLINE"
                fi

		;; 

esac
	
