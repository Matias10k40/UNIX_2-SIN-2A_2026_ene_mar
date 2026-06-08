#!/bin/bash
book="Black Hat Bash"
echo "This book's name is ${book}"
echo "This book's name is $book"
root_directory=$(ls -ld /)
echo "${root_directory}"
#drwxr-xr-x 1 root root 4096 Jun  1 15:00 /
book="Black Hat Bash"
unset book
echo "${book}"

