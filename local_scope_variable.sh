#!/bin/bash
# We assign the value "No Starch Press" to the variable PUBLISHER
# and define a function `print_name()` that declares a local variable
# called `name` with the value "Black Hat Bash". Because `name` is
# declared with `local` inside the function, it exists only within
# `print_name()` and cannot be accessed outside the function. Thus,
# attempting to echo `$name` after calling the function will produce
# an empty value.

PUBLISHER="No Starch Press"

print_name(){
	local name
	name="Black Hat Bash"
	echo "${name} by ${PUBLISHER}"
}

print_name

# The following echo demonstrates that `name` is not available here;
# it will expand to an empty string because `name` is local to the function.
echo "Outside function: name='${name}' (empty because 'name' is local to print_name())"
