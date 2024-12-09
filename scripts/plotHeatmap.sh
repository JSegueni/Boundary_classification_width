# plotHeatmap

# Input variables
# output: the matrix created by the computeMatrix script
# colorMap: YlOrRd
# yMin/yMax and zMin/zMax: depend on which signal is plotted
# refPointLabel: center
# xAxisLabel: TAD boundaries
# yAxisLabel: Signal

plotHeatmap -m $output.matrix.gz -out $output.heatmap.pdf --refPointLabel $refPointLabel --heatmapHeight 14 --colorMap $colorMap --yAxisLabel $yAxisLabel --xAxisLabel $xAxisLabel --regionsLabel $regionsLabel --zMin $zMin --zMax $zMax --yMin $yMin --yMax $yMax --outFileSortedRegions $output.sorted.regions.bed --sortRegions keep --averageTypeSummaryPlot mean --interpolationMethod bilinear
