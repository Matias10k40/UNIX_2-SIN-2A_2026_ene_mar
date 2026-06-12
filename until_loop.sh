#!/bin/bash
# Define the file name that will be checked
FILE="output.txt"
# Create the file if it does not already exist
touch "${FILE}"
# Keep checking until the file has some content
until [[ -s "${FILE}" ]]; do
    # Show a message saying the file is still empty
    echo "${FILE} is empty..."
    # Inform the user that the check will happen again soon
    echo "Checking again in 2 seconds..."
    # Wait 2 seconds before checking again
    sleep 2
done
# Print a message when the file contains content
echo "${FILE} appears to have some content in it!"