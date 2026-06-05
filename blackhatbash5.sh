#!/bin/bash
touch test && touch test123
(ls; ps)
ls; ps; whoami
lzl || echo "fallo el comando lzl"
echo "Hello World!" > output.txt
cat output.txt
echo "Bye World!" > output.txt
cat output.txt
echo "Goodbye!" >> output.txt
cat output.txt
ls -l / &> stdout_and_stderr.txt
ls -l / &>> stdout_and_stderr.txt
ls -l / 1> stdout.txt 2> stderr.txt