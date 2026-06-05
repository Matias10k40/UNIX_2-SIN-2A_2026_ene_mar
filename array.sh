#!/bin/bash
# Sets an array 
IP_ADDRESSES=(192.168.1.1 .192.168.1.2 192.168.1.3)
# Prints the first element of the array
set -x
echo "${IP_ADDRESSES[*]}"
set +x

echo "${IP_ADDRESSES[0]}"
#
#echo "${IP_ADDRESSES[*]}"
IP_ADDRESSES[0]="192.168.1.10"





