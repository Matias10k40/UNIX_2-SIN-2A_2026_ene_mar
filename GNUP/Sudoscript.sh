# Uses sudo to write 'hola' to /etc/archivo_protegido with root privileges.
sudo echo "hola" > /etc/archivo_protegido

# Pipes 'hola' to sudo tee, which writes it to /etc/archivo_protegido as root, suppressing output.
echo "hola" | sudo tee /etc/archivo_protegido > /dev/null

# Uses sudo to run a shell that appends 'chao' to /etc/archivo_protegido as root.
sudo sh -c 'echo "chao" >> /etc/archivo_protegido'

# Enters a temporary root session with sudo -i (interactive login); type 'exit' to return.
sudo -i

# Prints the expanded value of the $HOME variable (user's home directory).
echo "$HOME"

# Prints the literal string '$HOME' without expanding the variable.
echo '$HOME'

# Prints the expanded value of the $BASH variable (path to the bash executable).
echo "$BASH"

# Creates a new file 'hola.sh' and writes the shebang line for a shell script.
echo '#!/bin/sh'>hola.sh

# Appends the echo command to the hola.sh script file.
echo 'echo "Hola desde mi primer script"' >> hola.sh

# Displays the contents of the hola.sh file.
cat hola.sh

# Executes the hola.sh script.
./hola.sh

# Shows file details for hola.sh, including permissions and size.
ls -l hola.sh

# Makes hola.sh executable so it can be run directly.
chmod +x hola.sh