#!/bin/bash

#variables  vvvvv
wifi_netname=`iwgetid -r`
ipaddr=`hostname -I`
macaddr=`ip link sh wlan0 | awk '/link\/ether/ {print $2}'`
hostipnum= #this is defined below
chosenipaddr= #192.168.1.$hostipnum #this is defined below

#custom mini script (bash) programs

sudo_check()
{
    if [ $EUID -ne 0 ]; then
        echo "must run as root (sudo)"
        exit 1
    fi
}
sudo_check

ipaddr_ping_testing()
{
    read -p "host ip address number: " hostipnum
    chosenipaddr=192.168.1.$hostipnum
    echo ""
    echo "you have chosen ip address $chosenipaddr"
    echo ""
    ping -c 4 $chosenipaddr
    echo ""
    read -p "did the ping test fail (destination host unreachable) or succeed (must ans 'fail' or 'success': " userans
    echo "you answered: $userans"
}

ip_changing()
{
    nmcli con mod $wifi_netname ipv4.address $chosenipaddr/24 
    nmcli con mod $wifi_netname ipv4.gateway 192.168.1.1
    nmcli con mod $wifi_netname ipv4.dns 192.168.1.1,8.8.8.8
    nmcli con mod $wifi_netname ipv4.method manual
    nmcli con up $wifi_netname
}

#script start
echo ""
echo $wifi_netname
echo $ipaddr
echo $macaddr
echo ""

while true; do
    ipaddr_ping_testing

    #convert the user answer to lowercase for saftey
    #userans=$(echo "$userans" | tr '[:upper:]' '[:lower:]'
    if [ "$userans" = "success" ]; then
        echo ""
        echo retrying
        echo ""
    else
    #elif [ "$userans" = "fail" ]; then
        break #exit the loop if ping failed
    fi
done

#now running IP changing minigram

ip_changing

echo ""
echo "your current ip address for $wifi_netname is $(nmcli con show $wifi_netname | grep ipv4.addr | awk '{print $2}')"
#echo $(hostname -I)

#if statement asking if the user would like to rando their maco
read -p "" userans

if [ "" = "" ]; then
    echo ""
    echo ""
    echo ""
elif [ "" = "" ]; then
    echo ""
    echo ""
    echo ""
else
    echo ""
    echo "FUCK YOU try again"
    echo ""
fi
