  1# Typo: should be 'umask' (sets file permission mask)
  ummask
    2  umask
    3  touch archivo1
    4  mkdir directorio1
    5  ls -l
    6  -rw-r--r--r-- 1 usuario usuario 0 feb 20 ... archivo1
    7  -rw-r--r-- 1 usuario usuario 0 feb 20 ... archivo1
    8  -rw-r--r-- 1 usuario usuario 0 feb 20...archivo1
    9  umask 022
   10  touch archivo_nuevo.txt
   11  mkdir carpeta_nueva
   12  ls -l archivo_nuevo.txt
   13  ls -ld carpeta_nueva
   14  sudo apt-get update
   15  sudo apt-get install acl
   16  sudo chown -R $(whoami) .
   17  sudo setfacl -bnR .
   18  ummaks 027
   19  umask 027 
   20  touch archivo2
   21  mkdir directorio2
   22  ls -l
   23  sudo apt upgrade
   24  umask 077
   25  touch secreto.txt 
   26  mkdir privado
   27  ls -l 
   28  -rw------ 1 usuario usuario 0 feb 20...secretro.txt #600
   29  rw 1 usuario usuario 0 feb 20...secretro.txt #600
   30  history