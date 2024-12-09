import sys
import gzip
from collections import OrderedDict
import numpy as np
from copy import deepcopy

import pyBigWig
from deeptools import getScorePerBigWigBin
from deeptools import mapReduce
from deeptools.utilities import toString, toBytes, smartLabels
from deeptools.heatmapper_utilities import getProfileTicks

from __future__ import division

import argparse
from collections import OrderedDict
import numpy as np
import matplotlib
matplotlib.use('Agg')
matplotlib.rcParams['pdf.fonttype'] = 42
matplotlib.rcParams['svg.fonttype'] = 'none'
import matplotlib.pyplot as plt
from matplotlib.font_manager import FontProperties
import matplotlib.gridspec as gridspec
from matplotlib import ticker
import copy
import sys
import plotly.offline as py
import plotly.graph_objs as go

# own modules
from deeptools import cm  # noqa: F401
from deeptools import parserCommon
from deeptools import heatmapper
from deeptools.heatmapper_utilities import plot_single, plotly_single
from deeptools.utilities import convertCmap
from deeptools.computeMatrixOperations import filterHeatmapValues

from scipy.cluster.vq import vq, kmeans

hm = heatmapper.heatmapper()

matrix_file = "Bonev_IS_second.heatmap.relative.matrix.gz"

hm.read_matrix_file(matrix_file)

matrix = np.asarray(hm.matrix.matrix)

matrix_to_cluster = matrix

matrix_to_cluster.shape

if np.any(np.isnan(matrix_to_cluster)):
    sys.stderr.write("*Warning* For clustering nan values have to be replaced by zeros \n")
    matrix_to_cluster[np.isnan(matrix_to_cluster)] = 0

centroids, _ = kmeans(matrix_to_cluster, 3)

cluster_labels, _ = vq(matrix_to_cluster, centroids)

from sklearn.decomposition import PCA

pca = PCA(n_components=2)

import pandas as pd

principalComponents = pca.fit_transform(matrix_to_cluster)

principalDf = pd.DataFrame(data = principalComponents
             , columns = ['principal component 1', 'principal component 2'])

f, ax = plt.subplots()
ax.scatter(x=principalDf['principal component 1'], y=principalDf['principal component 2'])
#plt.show()
plt.savefig("before_kmeans.pdf", format="pdf")

matrix_with_centroids = matrix_to_cluster

matrix_with_centroids = np.append(matrix_with_centroids, centroids, axis=0)

from sklearn.decomposition import PCA

pca = PCA(n_components=2)

import pandas as pd

principalComponents_with_centroids = pca.fit_transform(matrix_with_centroids)

principalDf_with_centroids = pd.DataFrame(data = principalComponents_with_centroids
             , columns = ['principal component 1', 'principal component 2'])

cluster_labels_with_centroids = np.append(cluster_labels, [3,3,3])

for col in cluster_labels_with_centroids:
    if col==0:
        str.append("darkblue")
    if col==1:
        str.append("darkred")
    if col==2:
        str.append("orchid")
    if col==3:
        str.append("black")

f, ax = plt.subplots()
ax.scatter(x=principalDf_with_centroids['principal component 1'], y=principalDf_with_centroids['principal component 2'], c=str)
#plt.show()
plt.savefig("after_kmeans.pdf")






