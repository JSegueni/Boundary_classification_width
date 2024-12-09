#!/bin/bash


input_file="/store/EQUIPES/CHRODY/Hanae/ChromHMM/new_data2/3ES_cool_250kb.heatmap.2ndDeriv.relative.matrix"


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


