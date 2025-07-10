#!/bin/bash
#execute the speedtest
#print the current date & time
#pull out the area or ip address where it is being tested
#pull out the download speed
#
#if the download speed is less than 40Mb
#   -echo "this line/network sucks, choose a different connection
#else if its greater than 40Mb
#   -echo back saying "network is great, keep using it!"
#
#pull out the upload speed
#
#script start

curdate=`date`
#speedresults=output.txt
speedresult="/home/$USER/output.txt"

echo ""
echo "current date & time is: $curdate"
echo ""
#echo "please wait for the speed test to complete
#as it will not show up visible on screen"

speedtest-cli --secure > $speedresult

cat $speedresult
echo ""

#line 1 is being pulled for pulling the ip address of the speed-test
#line 7 is being pulled for getting the download speed
#line 9 is being pulled for getting the upload speed

#while loop is being used basically to pull specific line containing info we want from the speed test-
#so that we can manipulate the info & output it

while read -r line1 && read -r line7 && read -r line9; do
    #speedtesttargetip=$(echo "$line1" | grep -Po '\(\K[^)]*' | awk NR==1)
    #targip=$(echo "$line1")
    downspeed=$(echo "$line7" | awk '{print $2}')
    upspeed=$(echo "$line9" | awk '{print $2}')
    echo $speedtesttargetip
    #echo $targip
    echo test
    echo $downspeed
    echo $upspeed
done < $speedresult

echo ""
rm $speedresult
