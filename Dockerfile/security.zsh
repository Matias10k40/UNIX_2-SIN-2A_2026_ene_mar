id 
# See the main group
id -gn # Name of the lead group
# Create one file and see the group
touch ~/test_grupo_heredado.txt
ls -la  ~/test_grupo_heredado.txt
#The grup is the gruop principal of the user
newgrp desarrollo
# See the new group
id -gn
# Create one file and see the group
echo "Nuevo grupo activo: $(id -gn)"

