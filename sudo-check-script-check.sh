#!/bin/bash

#checks if the user is root (sudo)
sudo_check()
{
    if [ $EUID -ne 0 ]; then
        echo "must run as root (sudo)"
        exit 1
    fi
}

sudo_check

echo "success"
