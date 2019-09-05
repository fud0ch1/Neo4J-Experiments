""" Remove Symbol '|' """
sed 's/|* //' file1.csv > file2.csv

""" Remove Numbers """
sed 's/[0-9]* //' file1.csv > file2.csv
