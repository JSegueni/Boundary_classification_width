library(BRGenomics)

Bonev_IS <- import.bw("Bonev_IS_from_Chang_2023.bw")

Bonev_IS_dev <- import.bw("Derivative_Bonev_IS_from_Chang_2023.bw")

derivative <- function(vec)
{
    i = 1
    res <- c()
    while (i < length(vec))
    {
        res[i] = vec[i+1]-vec[i]
        i = i + 1
    }
    return(res)
}

second_dev_score = derivative(Bonev_IS_dev$score)

Bonev_IS_second_dev <- GRanges(seqnames=seqnames(Bonev_IS_dev[2:length(Bonev_IS_dev)-1]), seqinfo=seqinfo(Bonev_IS),
                               ranges=ranges(Bonev_IS_dev[2:length(Bonev_IS_dev)-1]),
                               score=second_dev_score)

export.bw(Bonev_IS_second_dev, "Second_derivative_Bonev_IS.bw")
