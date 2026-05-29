id 
# See the main group
id -gn # Name of the lead group
# Create one file and see the group
touch ~/test_grupo_heredado.txt
ls -la  ~/test_grupo_heredado.txt
#The grup is the gruop principal of the user
groups
# Create a new group and add the user to it
newgrp desarrolladores
# See the new group
id -gn
# Create one file and see the group
touch ~/antes_de_newgrp.txt
ls -la ~/antes_de_newgrp.txt
# Create one file and see the group

