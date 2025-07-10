#!/bin/bash

gate=`route -n | awk NR==3 | awk {'print $2'}`
cidernum=`ip addr sh wlan0 |awk NR==3 | awk {'print $2'} | xargs -I @ basename @`

#checks if the user is root (sudo)
sudo_check()
{
    if [ $EUID -ne 0 ]; then
        echo "must run as root (sudo)"
        exit 1
    fi
}

sudo_check

#starts the scan for a half-ping scan
scan()
{
    sudo nmap -sn $gate/$cidernum > output.txt
    #cuts the first line of the file, indicating nmap scan start
    sed -i '1d;$d' output.txt
}

echo $gate"/"$cidernum
echo ""
echo "begin scan"
echo ""
echo "      IP Address        |       MAC Address         |    Device Name
==============================================================================="

#sudo nmap -sn $gate/$cidernum > output.txt
#cuts the first line of the file, indicating nmap scan start
#sed -i '1d;$d' output.txt

scan

#loops thru the file & prints it
while read -r line1 && read -r line2 && read -r line3; do
    curIP=$(echo $line1 | awk '{print $5}')
    MACaddr=$(echo $line3 | awk '{print $3}')
    devname=$(echo "$line3" | awk '{print $4,$5}')
    echo -e "      $curIP\t      $MACaddr\t         $devname"
done < output.txt
rm output.txt
