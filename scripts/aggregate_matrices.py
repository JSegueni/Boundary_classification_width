# import standard python libraries
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
import seaborn as sns

import cooler
import bioframe
import cooltools

from packaging import version
if version.parse(cooltools.__version__) < version.parse('0.5.0'):
    raise AssertionError("tutorials rely on cooltools version 0.5.0 or higher,"+
                         "please check your cooltools version and update to the latest")

resolution = 10000
Bonev_clr = cooler.Cooler("Bonev_10000_mES.cool")

# Use bioframe to fetch the genomic features from the UCSC.
mm10_chromsizes = bioframe.fetch_chromsizes('mm10')
mm10_cens = bioframe.fetch_centromeres('mm10', verbose=True)
mm10_arms = bioframe.make_chromarms(mm10_chromsizes, mm10_cens)

import cooltools.lib.plotting

import bbi

def pileup_border(clr, tsv, resolution, flank, figsize=[10,10]):
    # Use bioframe to fetch the genomic features from the UCSC.

    
    tsv_df = pd.read_csv(tsv, sep='\t')
    tsv_df.rename(columns={"seqnames":"chrom"}, inplace=True)
    stack = cooltools.pileup(clr, tsv_df, view_df=mm10_arms, flank=flank)
    mtx = np.nanmean(stack, axis=2)

    f, ax = plt.subplots(figsize=figsize)

    im = ax.imshow(
        np.log10(mtx),
        cmap='fall',
        interpolation='none')

    plt.colorbar(im, label = 'log10 mean')
    ticks_pixels = np.linspace(0, flank*2//resolution,5)
    ticks_kbp = ((ticks_pixels-ticks_pixels[-1]/2)*resolution//1000).astype(int)
    plt.xticks(ticks_pixels, ticks_kbp)
    plt.yticks(ticks_pixels, ticks_kbp)
    plt.xlabel('relative position, kbp')
    plt.ylabel('relative position, kbp')
    return(stack)


cluster1_stack = pileup_border(Bonev_clr, "Bonev_second_derivative_cluster1.tsv", resolution=10000, flank=250000)

cluster2_stack = pileup_border(Bonev_clr, "Bonev_second_derivative_cluster2.tsv", resolution=10000, flank=250000)

cluster3_stack = pileup_border(Bonev_clr, "Bonev_second_derivative_cluster3.tsv", resolution=10000, flank=250000)
    
