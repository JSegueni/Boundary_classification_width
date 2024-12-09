# Define the calculated mean
mean_value=-0.0211774

# Input file name
input_file="/store/EQUIPES/CHRODY/Hanae/ChromHMM/new_data2/3NPC_cool_250kb.heatmap.2ndDeriv.relative.matrix"

# Parameters for starting columns
col_start_left=31  # Starting column number for the left loop
col_start_right=33 # Starting column number for the right loop

# Execute awk with the parameters
awk -v mean="$mean_value" -v start_left="$col_start_left" -v start_right="$col_start_right" '
NR > 1 {
    left_boundary_count = 0
    right_boundary_count = 0

    # Loop through the left columns from start_left to column 7
    for (i = start_left; i >= 7; i--) {
        if ($i < mean) {
            break
        }
        left_boundary_count++
    }

    # Loop through the right columns from start_right to the last column
    for (i = start_right; i <= NF; i++) {
        if ($i < mean) {
            break
        }
        right_boundary_count++
    }

    # Print the results for each row
    print "left_boundary:", left_boundary_count, "right_boundary:", right_boundary_count
}
' "$input_file"


