#!/bin/bash

echo "Hello $USER"
echo "Starting google ping script"

ping -c5 8.8.8.8

##veterans 
#if statement stating connection status - failed or success

if (ping -c 5 8.8.8.8 | grep -P "Destination Host Unreachable")
then
    echo "failed";
else
    echo "success"
fi

#end of bash script
