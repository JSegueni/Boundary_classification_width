# from iced_to_cool

# Input variables
# input: input matrix from bg2 (converted from iced Hi-C pro matrices)
# output: cool matrix

cooler load -f bg2 --count-as-float mm10.chrom.sizes:10000 $input $output &&\
cooler balance $output -p 10
