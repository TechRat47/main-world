#!/bin/bash

#instructions
#SSH logs script
#- Parse thru all the ssh auth logs
#- show all the current & past login attempts
#- successful & failed attempts
#- check for root user
#- should show the ip address, the user logged in, & time for user
#- IP address ---- User ---- Failed or success ---- Time of login
#
#- after you finish up the pasing part
#write the history of the logs into a file that can be read afterwards

#variables
curdate=`date | tr ' ' '-'`
neatlylogged="/home/$USER/output$curdate.txt"
username=`$USER`
#neatlylogged="`~`/output-$curdate.txt"

#functions

sudo_check()
{
    if [ $EUID -ne 0 ]; then
        echo "must run as root (sudo)"
        exit 1
    fi
}
sudo_check
#script start
echo $username

#sudo su lspicher
#touch $neatlylogged
#echo "test test test" > $neatlylogged
#cat $neatlylogged
