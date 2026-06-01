#!/usr/bin/env bash
set -x
bash --version 
env
echo ${SHELL}
echo ${RANDOM}
echo ${UID}
echo ${OSTYPE}
ps -e -f
ps -ef
df --human-readable
bash -r blackhatbash1.sh  
echo "Hello World!" 
bash helloworld.sh
bash -n script.sh
bash -x script.sh
set +x 