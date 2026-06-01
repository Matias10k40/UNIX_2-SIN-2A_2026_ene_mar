# Print the current shell being used
echo $SHELL
# Expected output: /bin/bash (or similar shell path)

 
# Display a simple message to the terminal (echo command)
echo "Hello, Linux!"
 
# Display text without a newline at the end (-n option)
echo -n "This has no newline: "
echo "next line"

# List files in the current directory
ls
# List files in long format (detailed view)
ls -l
# List all files including hidden files
ls -a
# List all files in long format (most common combination)
ls -la
# List files in a specific directory
ls /etc
# Print the current working directory
pwd
# Example output: /home/sysadmin

# Go to the home directory
cd ~
# Go to the root directory
cd /
# Return to home directory
cd ~
# Go to the Documents directory inside home
cd ~/Documents
# Go one level up (parent directory)
cd ..
# Go to the previous directory
cd -

# Switch to root user (will prompt for root password)
su
# Switch to a specific user
su username
# Run a command as administrator with sudo
sudo command
# Example: update packages using sudo (safe to show, not execute here)
sudo apt-get update

# View permissions of files in current directory
ls -l
# View permissions of a specific file
ls -l /etc/passwd

 
# Create a test file to demonstrate chmod
touch testfile.txt
# Add execute permission for the owner (symbolic mode)
chmod u+x testfile.txt
# Remove write permission from group
chmod g-w testfile.txt
# Set permissions to rwxr-xr-x (numeric mode) = 755
chmod 755 testfile.txt
# Set permissions to rw-r--r-- (numeric mode) = 644
chmod 644 testfile.txt
# Set permissions to rwx------ (numeric mode) = 700
chmod 700 testfile.txt
# Verify the permissions changed
ls -l testfile.txt

# Show current ownership of the test file
ls -l testfile.txt
# Change owner of a file (requires sudo)
sudo chown root testfile.txt
# Change both owner and group
sudo chown root:root testfile.txt
# Change only the group
sudo chown :sysadmin testfile.txt

# Create example files for demonstration
mkdir -p ~/Documents/Work
touch ~/Documents/file1.txt
touch ~/Documents/file2.txt
touch ~/Documents/file3.txt
 
# Rename a file (move it to a new name in the same directory)
mv ~/Documents/file1.txt ~/Documents/renamed_file.txt
# Move a file to another directory
mv ~/Documents/renamed_file.txt ~/Documents/Work/
# Move multiple files to a directory
mv ~/Documents/file2.txt ~/Documents/file3.txt ~/Documents/Work/
# Verify the move
ls ~/Documents/Work/


# Copy a file to the current directory (. = current directory)
cp /etc/passwd .
# Copy a file to a specific destination with a new name
cp /etc/passwd ~/Documents/passwd_backup.txt
# Copy a file into a directory
cp testfile.txt ~/Documents/
# Copy a directory and all its contents recursively
cp -r ~/Documents/Work ~/Documents/Work_backup
# Verify the copy
ls ~/Documents/
 
 # Create a 50MB swap file using dd
if=/dev/zero  : reads zeros (null data) as input
of=/tmp/swapex: writes output to this file
bs=1M         : each block is 1 megabyte
count=50      : copy 50 blocks = 50MB total
dd if=/dev/zero of=/tmp/swapex bs=1M count=50
# Verify the file was created and check its size
ls -lh /tmp/swapex
# Another example: copy the first 512 bytes of a disk (MBR backup)
# dd if=/dev/sda of=~/mbr_backup.bin bs=512 count=1
# Note: This requires sudo and is commented out for safety

# Remove a single file
rm ~/Documents/passwd_backup.txt
# Remove a file with confirmation prompt (-i is safer)
rm -i testfile.txt
# Remove a directory and all its contents recursively
rm -r ~/Documents/Work_backup
# Force remove without prompting (use with caution!)
rm -rf directory_name
# Verify removal
ls ~/Documents/


# Search for the word "root" in the passwd file
grep "root" /etc/passwd
# Case-insensitive search
grep -i "ROOT" /etc/passwd
# Show line numbers with matches
grep -n "sysadmin" /etc/passwd
# Search with pipe (filter output of another command)
ls -la | grep "txt"


# Match lines starting with "root" (^ = start of line)
grep "^root" /etc/passwd
# Match lines ending with "bash" ($ = end of line)
grep "bash$" /etc/passwd


# Match lines containing any digit
grep "[0-9]" /etc/passwd
# Match lines starting with a letter between a-z
grep "^[a-z]" /etc/passwd


# Shut down immediately
sudo shutdown now
# Shut down in 5 minutes with a message to users
sudo shutdown +5 "System going down for maintenance"
# Reboot the system immediately
sudo shutdown -r now
# Cancel a scheduled shutdown
sudo shutdown -c

# Display all network interfaces and their configuration
ifconfig
# Display a specific interface (e.g., eth0)
ifconfig eth0
# Display wireless network interfaces
iwconfig
# Display network info using the modern 'ip' command (alternative)
ip addr show


# Show processes in the current terminal session
ps
# Show all processes on the system
ps -e
# Show all processes with detailed info (user, CPU, memory)
ps aux
# Combine with grep to find a specific process
ps aux | grep "bash"


# Update the package list (always do this before installing)
sudo apt-get update
# Install a package (example: install 'tree' command)
sudo apt-get install tree
# Remove a package (keeps configuration files)
sudo apt-get remove tree
# Completely remove a package including config files
sudo apt-get purge tree
# Upgrade all installed packages to latest versions
sudo apt-get upgrade


# Change the current user's password (interactive - prompts for new password)
passwd
# Change another user's password (requires sudo)
sudo passwd username


# Open a file with vi (interactive - opens editor)
vi myfile.txt
# Create and write to a file non-interactively using echo (alternative to vi)
echo "This is a test file created for the Linux Unhatched course" > ~/testfile_vi.txt
# View the contents of the file
cat ~/testfile_vi.txt


# cat - Display the contents of a file
cat /etc/passwd
man - Display the manual page for a command (help documentation)
man ls
man cp
man grep
# history - Show the list of previously executed commands
history
# head - Show the first 10 lines of a file
head /etc/passwd
# tail - Show the last 10 lines of a file
tail /etc/passwd


# Remove the test swap file created with dd
rm -f /tmp/swapex
# Remove the test file created earlier
rm -f testfile.txt
# Remove the test text file
rm -f ~/testfile_vi.txt
