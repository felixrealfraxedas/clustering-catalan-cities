import numpy as np
import matplotlib.pyplot as plt
import pandas as pd

from mst_clustering import MSTClustering

# Load the data and filter by population
municipis_df = pd.read_csv("dades_tots_municipis_netes.csv")
X_all = municipis_df[['Longitud', 'Latitud']].to_numpy()

population = 5000
filtered_municipis = municipis_df[municipis_df['Poblacio'] > population]
X = filtered_municipis[['Longitud', 'Latitud']].to_numpy()

# Clustering: for both cases (more than 5000 inhab. and all the towns), we implemented an iterative
# method to finish with the desired number of clusters (4)
k = 0
min_cutoff_scale = 0
max_cutoff_scale = 2
curr_cutoff_scale = 1

while(k != 4):
    model = MSTClustering(cutoff_scale=curr_cutoff_scale, approximate=False)
    labels = model.fit_predict(X)

    k = len(np.unique(labels))
    print(k, curr_cutoff_scale)
    if (k > 4):
        min_cutoff_scale = curr_cutoff_scale
        curr_cutoff_scale = (curr_cutoff_scale + max_cutoff_scale)/2
    elif (k < 4):
        max_cutoff_scale = curr_cutoff_scale
        curr_cutoff_scale = (curr_cutoff_scale + min_cutoff_scale)/2

plt.figure(figsize=(10, 10))
plt.scatter(X[:, 0], X[:, 1], c=labels, cmap='rainbow')
plt.title("Municipis of Catalonia of more than 5000 unhab. grouped by 'Provincia'", fontsize = 20)
plt.savefig("mst_provincies.png")

k = 0
min_cutoff_scale = 0
max_cutoff_scale = 2
curr_cutoff_scale = 1

while(k != 4):
    model = MSTClustering(cutoff_scale=curr_cutoff_scale, approximate=False)
    labels = model.fit_predict(X_all)

    k = len(np.unique(labels))
    print(k, curr_cutoff_scale)
    if (k > 4):
        min_cutoff_scale = curr_cutoff_scale
        curr_cutoff_scale = (curr_cutoff_scale + max_cutoff_scale)/2
    elif (k < 4):
        max_cutoff_scale = curr_cutoff_scale
        curr_cutoff_scale = (curr_cutoff_scale + min_cutoff_scale)/2

plt.figure(figsize=(10, 10))
plt.scatter(X_all[:, 0], X_all[:, 1], c=labels, cmap='rainbow')
plt.title("Municipis of Catalonia grouped by 'Provincia'", fontsize = 20)
plt.savefig("mst_provincies_all.png")
