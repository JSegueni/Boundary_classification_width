# computeMatrix_IS

# output: considered matrix (combination of specific bigwig(s) + specific region(s))
# region: boundaries from Chang et al. 2023
# scores: Insulation from score Bonev et al. 2017 analyzed in Chang et al. 2023, or its first derivative, or its second derivative
# binSize: 10000
# bef: 100000 or 250000
# blacklist: mm10_blacklist_v2.bed (from the Boyle Lab's github)
# scoresLabel: Bonev_IS or 1st_dev_IS or 2nd_dev_IS

computeMatrix reference-point -o $output.matrix.gz --outFileNameMatrix $output.matrix.tab --outFileSortedRegions $output.regions.bed -S $scores -R $region -b $(($((bef))+$((binSize)))) -a $bef --samplesLabel $samplesLabel --skipZeros --missingDataAsZero --referencePoint center -bs $binSize -p 5
