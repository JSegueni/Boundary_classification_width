#!/bin/bash


input_file="Second_derivative_Insulation_score_Bonev_2017_mES_all_clusters_250kb_heatmap.relative.matrix"


awk 'NR > 1 { 
    sum = 0; 
    count = 0; 
    for (i = 7; i <= NF; i++) { 
        sum += $i; 
        count++; 
    } 
    total_sum += sum; 
    total_count += count; 
} 
END { 
    mean = total_sum / total_count; 
    print "Mean of remaining values:", mean 
}' "$input_file"


