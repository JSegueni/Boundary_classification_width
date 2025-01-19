#!/bin/bash

# Input and output files
input_file="results_mES_corrected.txt"
output_file="results_mES_formatted.txt"

# Process the file and format it with column headers
awk '
BEGIN {
    # Print the header
    print "left_boundary\tright_boundary\tsize\tleft_boundary_corrected\tright_boundary_corrected"
}
{
    # Extract the values and format them as a table
    print $2 "\t" $4 "\t" $6 "\t" $8 "\t" $10
}' "$input_file" > "$output_file"

echo "Formatted file saved to $output_file"


