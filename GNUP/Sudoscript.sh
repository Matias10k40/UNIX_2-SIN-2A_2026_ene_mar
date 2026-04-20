# Uses sudo to write 'hola' to /etc/archivo_protegido with root privileges.
sudo echo "hola" > /etc/archivo_protegido

# Pipes 'hola' to sudo tee, which writes it to /etc/archivo_protegido as root, suppressing output.
echo "hola" | sudo tee /etc/archivo_protegido > /dev/null

# Uses sudo to run a shell that appends 'chao' to /etc/archivo_protegido as root.
sudo sh -c 'echo "chao" >> /etc/archivo_protegido'

# Enters a temporary root session with sudo -i (interactive login); type 'exit' to return.
sudo -i