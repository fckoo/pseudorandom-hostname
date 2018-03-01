#!/bin/bash

# Copy the old /etc/hosts
cp -n /etc/hosts{,.old}

# Generate and store the new hostname
newHostname=$(cat /dev/urandom | tr -dc 'A-Za-z' | head -c8)
echo $newHostname > /etc/hostname

# Create a new /etc/hosts file
echo "127.0.0.1    localhost" > /etc/hosts
echo "127.0.0.1    $newHostname" >> /etc/hosts

# Concatenate the old hosts file to the new one
cat /etc/hosts.old >> /etc/hosts

service hostname.sh stop
sleep 1
service hostname.sh start
xhost +$newHostname
exit
