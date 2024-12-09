# computeMatrix

# Input variables
# scores can be CTCF binding, Rad21 binding, ATAC-seq or PRO-seq signals in BigWig format.
# regions are the boundary clusters BED files
# blacklist is from the Boyle lab for mm10
# bef can be 100kb or 250kb
# binSize is 10000
# maxThreshold is at 1000 to remove outliers in ATAC-seq data

computeMatrix reference-point -o $output.matrix.gz --outFileNameMatrix $output.matrix.tab --outFileSortedRegions $output.regions.bed -S $scores -R $region -b $bef -a $bef --samplesLabel $samplesLabel --referencePoint center -bs $binSize --missingDataAsZero --skipZeros --blackListFileName $blacklist --maxThreshold 1000 -p 5
