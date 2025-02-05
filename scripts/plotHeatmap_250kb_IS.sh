# plotHeatmap_IS

# Input variables:
# output: considered matrix created by computeMatrix_IS (without the gz extension already written in the code)
# colorMap: seismic

# 1st part of the script runs the plotHeatmap command a first time and creates a raw non-normalized matrix of the insulation score on the considered regions.
# 2nd part of the script applies a local normalization (so that the center bin signal is at 0) by removing the center bin signal to each bin's signal. 
# 3rd part of the script runs the plotHeatmap command a second time to plot the relative heatmap normalized in the 2nd part

plotHeatmap -m $output.matrix.gz -out $output.heatmap.pdf --outFileNameMatrix $output.heatmap.matrix.gz --refPointLabel $refPointLabel --heatmapHeight 14 --colorMap $colorMap --yAxisLabel $yAxisLabel --xAxisLabel $xAxisLabel --regionsLabel $regionsLabel --zMin $zMin --zMax $zMax --yMin $yMin --yMax $yMax --sortRegions keep && \
gunzip $output.heatmap.matrix.gz && \
awk '{if (NR<2) {print $0} else{ print $1 "\t" $2 "\t" $3 "\t" $4 "\t" $5 "\t" $6 "\t" $7-$32 "\t" $8-$32 "\t" $9-$32 "\t" $10-$32 "\t" $11-$32 "\t" $12-$32 "\t" $13-$32 "\t" $14-$32 "\t" $15-$32 "\t" $16-$32 "\t" $17-$32 "\t" $18-$32 "\t" $19-$32 "\t" $20-$32 "\t" $21-$32 "\t" $22-$32 "\t" $23-$32 "\t" $24-$32 "\t" $25-$32 "\t" $26-$32 "\t" $27-$32 "\t" $28-$32 "\t" $29-$32 "\t" $30-$32 "\t" $31-$32 "\t" $32-$32 "\t" $33-$32 "\t" $34-$32 "\t" $35-$32 "\t" $36-$32 "\t" $37-$32 "\t" $38-$32 "\t" $39-$32 "\t" $40-$32 "\t" $41-$32 "\t" $42-$32 "\t" $43-$32 "\t" $44-$32 "\t" $45-$32 "\t" $46-$32 "\t" $47-$32 "\t" $48-$32 "\t" $49-$32 "\t" $50-$32 "\t" $51-$32 "\t" $52-$32 "\t" $53-$32 "\t" $54-$32 "\t" $55-$32 "\t" $56-$32 "\t" $57-$32}}' $output.heatmap.matrix > $output.heatmap.relative.matrix && \
gzip $output.heatmap.relative.matrix && \
plotHeatmap -m $output.heatmap.relative.matrix.gz -out $output.heatmap.relative.pdf --refPointLabel $refPointLabel --heatmapHeight 14 --colorMap $colorMap --yAxisLabel $yAxisLabel --xAxisLabel $xAxisLabel --regionsLabel $regionsLabel --zMin $zMin --zMax $zMax --yMin $yMin --yMax $yMax --outFileSortedRegions $output.sorted.regions.bed --sortRegions keep --interpolationMethod bilinear
