 #!/usr/bin/env bash
 touch example_file1 example_file2 example_file3
 grep "35.237.4.214" log.txt
 grep "35.237.4.214\|13.66.139.0" log.txt
 grep -e "35.237.4.214" -e "13.66.139.0" log.txt
 ps | grep TTY
 ps | grep -i tty
 grep -v "35.237.4.214" log.txt
 grep -o "35.237.4.214" log.txt
awk -F',' '{print $1}' example_csv.txt
awk 'NR < 10' log.txt
# grep searches the log lines that contain that IP.
grep "42.236.10.117" log.txt

# awk prints the seventh field of each line.
awk '{print $7}' log.txt

# together: they filter that IP and then extract field 7 from the matching lines.
grep "42.236.10.117" log.txt | awk '{print $7}'
awk -F',' '{print $1}' test.csv | grep "example_file"
awk -F',' '{print $1}' test.csv | grep "example_file" | sort
sed 's/Mozilla/Godzilla/g' log.txt
sed 's/Mozilla/Godzilla/g' log.txt > newlog.txt
sed 's/ //g' log.txt
sed '1d' log.txt
sed '$d' log.txt
sed '5,7d' log.txt
sed -n '2,15 p' log.txt
sed -i '1d' log.txt