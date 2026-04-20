# Uses sudo to write 'hola' to /etc/archivo_protegido with root privileges.
sudo echo "hola" > /etc/archivo_protegido

# Pipes 'hola' to sudo tee, which writes it to /etc/archivo_protegido as root, suppressing output.
echo "hola" | sudo tee /etc/archivo_protegido > /dev/null