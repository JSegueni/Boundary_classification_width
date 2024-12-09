# plotHeatmap_IS_cluster

# Input variables:
# output: considered matrix created by computeMatrix_IS (without the gz extension already written in the code), here this is specifically the second derivative of the IS from Bonev et al. 2017
# colorMap: seismic

# 1st part of the script runs the plotHeatmap command a first time and creates a raw non-normalized matrix of the insulation score on the considered regions.
# 2nd part of the script applies a local normalization (so that the center bin signal is at 0) by removing the center bin signal to each bin's signal. 
# 3rd part of the script runs the plotHeatmap command a second time to plot the relative heatmap normalized in the 2nd part. This command also performs a k-means clustering with 3 centroids on the second derivative to identify 3 clusters of TAD boundaries, with 3 different insulation patterns. 

plotHeatmap -m $output.matrix.gz -out $output.heatmap.clust.pdf --outFileNameMatrix $output.heatmap.matrix.clust.gz --refPointLabel $refPointLabel --heatmapHeight 14 --colorMap $colorMap --yAxisLabel $yAxisLabel --xAxisLabel $xAxisLabel --regionsLabel $regionsLabel --zMin $zMin --zMax $zMax --yMin $yMin --yMax $yMax && \
gunzip $output.heatmap.matrix.clust.gz && \
awk '{if (NR<2) {print $0} else{ print $1 "\t" $2 "\t" $3 "\t" $4 "\t" $5 "\t" $6 "\t" $7-$17 "\t" $8-$17 "\t" $9-$17 "\t" $10-$17 "\t" $11-$17 "\t" $12-$17 "\t" $13-$17 "\t" $14-$17 "\t" $15-$17 "\t" $16-$17 "\t" $17-$17 "\t" $18-$17 "\t" $19-$17 "\t" $20-$17 "\t" $21-$17 "\t" $22-$17 "\t" $23-$17 "\t" $24-$17 "\t" $25-$17 "\t" $26-$17 "\t" $27-$17}}' $output.heatmap.matrix.clust > $output.heatmap.relative.matrix.clust && \
gzip $output.heatmap.relative.matrix.clust && \
echo "matrix OK" && \
plotHeatmap -m $output.heatmap.relative.matrix.clust.gz -out $output.heatmap.relative.clust.pdf --refPointLabel $refPointLabel --heatmapHeight 14 --colorMap $colorMap --regionsLabel $regionsLabel --kmeans 3 --outFileSortedRegions $output.sorted.regions.bed

