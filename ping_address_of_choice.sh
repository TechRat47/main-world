#!/bin/bash
#
#asking user for an IP address to ping
#IP_address

#$IP_address = "what IP address would you like to ping (must be in the following format *.*.*.*"

#ipaddr="what IP address would you like to ping (must be in the following format *.*.*.*":

#ipaddr=127.0.0.1
echo ""
read -p "what IP address would you like to try to ping (must be in the format *.*.*.* :" ipaddr

echo "IP address to be pinged $ipaddr"

if (ping -c 4 $ipaddr |  grep -P "0% packet loss")
then
    echo "success"
fi
#then (ping -c 4 $ipaddr | grep -P "0% packet loss")
if (ping -c 4 $ipaddr | grep -P "100% packet loss")
    echo "failed"
fi
