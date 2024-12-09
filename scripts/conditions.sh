#!/bin/bash

# Input file
input_file="resultats_3CN.txt"
output_file="resultats_3CN_corrected.txt"

awk '
{
    # Parse left_boundary and right_boundary from the input file
    left_boundary = $2;
    right_boundary = $4;

    # Calculate size
    size = left_boundary + right_boundary + 1;

    # Condition 1: Correct left_boundary if size equals 1
    if (size == 1) {
        left_boundary_corrected = left_boundary + 1;
    } else {
        left_boundary_corrected = left_boundary;
    }

    # Condition 2: Check for boundary values of 25
    if (left_boundary_corrected == 25 || right_boundary == 25) {
        left_boundary_corrected = "INF";
        right_boundary = "INF";
    }

    # Print the updated values
    print "left_boundary:", left_boundary, "right_boundary:", right_boundary, \
          "size:", size, "left_boundary_corrected:", left_boundary_corrected, "right_boundary_corrected:", right_boundary;
}' "$input_file" > "$output_file"

echo "Corrected file has been saved to $output_file"







