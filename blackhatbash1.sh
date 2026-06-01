#!/usr/bin/env bash
set -x
bash --version
env
echo "${SHELL}"
echo "${RANDOM}"
echo "${UID}"
echo "${OSTYPE}"
ps -e -f
ps -ef
df --human-readable
echo "Hello World!"
# Para ejecutar otro script usa la ruta del archivo:
# ./helloworld.sh
# ./script.sh
# Para verificar sintaxis sin ejecutar usa:
# bash -n script.sh
set +x
# + df --human-readable
# Filesystem      Size  Used Avail Use% Mounted on
# overlay          32G   13G   18G  42% /
# tmpfs            64M     0   64M   0% /dev
# shm              64M     0   64M   0% /dev/shm
# /dev/root        29G   23G  6.3G  79% /vscode
# /dev/sdb1        44G  2.8G   39G   7% /tmp
# /dev/loop4       32G   13G   18G  42% /workspaces
# + echo 'Hello World!'
# Hello World!
# + set +x
++ echo -n '(Black-Hat-Bash'
+++ git config --get devcontainers-theme.show-dirty
++ '[' '' = 1 ']'
++ echo -n ') '
++ __vsc_preexec_only -x
++ '[' 1 = 0 ']'
+ set +x