We use a for loop to iterate over the output of the ls . command,
which lists the files in the current directory. Each file will be assigned to the
file variable as part of the for loop, so we can then use echo to print its
name. This technique would be useful, for example, if we wanted to
perform an upload of all files in the directory or even rename them in bulk.
break and continue
Loops can run forever or until a condition is met. But we can also exit a
loop at any point by using the break keyword. This keyword provides an
alternative to the exit command, which would cause the entire script, not
just the loop, to exit. Using break, we can leave the loop and advance to the
next code block (Listing 2-22).
#!/bin/bash
while true; do
 echo "in the loop"
 break
done
echo "This code block will be reached."
Listing 2-22: Breaking from a loop
In this case, the last echo command will be executed.
The continue statement is used to jump to the next iteration of a loop.
We can use it to skip a certain value in a sequence. To illustrate this, let’s
create three empty files so we can iterate through them:
$ touch example_file1 example_file2 example_file3
Next, our for loop will write content to each file, excluding the first
one, example_file1, which the loop will leave empty (Listing 2-23).
#!/bin/bash
for file in example_file*; do
 if [["${file}" == "example_file1"]]; then
 echo "Skipping the first file"
continue
 fi
 echo "${RANDOM}" > "${file}"
done