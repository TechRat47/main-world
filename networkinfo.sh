#!/bin/bash

#grab the ssid of the wifi network
#grab your ip address
#grab the netmask/subnetmask
#grab the ip address of the router (gateway address)
#display back just the password of the wifi network
#grab the mac address of your device

#script start  vvvv

#wifi name
wifi_name=`iwgetid -r`
echo "SSID: $wifi_name"

#device ip address
devip=`hostname -I`
echo "IP address: $devip"

#subnetmask
netmask=`ifconfig | grep netmask | awk NR==2 | awk '{print $4}'`
echo "subnet-netmask: $netmask"

#wifi gateway
route_gate=`route -n | awk NR==3 | awk {'print $2'}`
echo "router gateway IP: "$route_gate

#wifi password
echo "sudo required to show wifi password"
wifi_password=`nmcli dev w show-password | awk NR==3 | awk {'print $2'}`
echo $wifi_password

#device mac  address
dev_mac=`ip link sh wlan0 | awk '/link\/ether/ {print $2}'`
echo "device mac address: $dev_mac"

#device interface
#
echo "wlan0"
