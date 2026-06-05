#!/bin/bash
touch test && touch test123
(ls; ps)
ls; ps; whoami
lzl || echo "fallo el comando lzl"
echo "Hello World!" > output.txt
cat output.txt
echo "Bye World!" > output.txt
cat output.txt
