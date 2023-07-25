## k-means
## Grouping "municipis" of Catalonia in 4 regions ("províncies")
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd

from sklearn.cluster import KMeans

# "Municipis" data
municipis_df = pd.read_csv("dades_tots_municipis_netes.csv")

# Filtering by population
population = 5000
filtered_municipis = municipis_df[municipis_df['Poblacio'] > population]
X = filtered_municipis[['Longitud', 'Latitud']].to_numpy()

X_all = municipis_df[['Longitud', 'Latitud']].to_numpy()

# Grouping in clusters
y_pred1 = KMeans(n_clusters=4).fit_predict(X)
y_pred2 = KMeans(n_clusters=4).fit_predict(X_all)

# Results to a .csv file
filtered_municipis['Provincia'] = y_pred1
filtered_municipis.to_csv('Resultats_k-means.csv')

municipis_df['Provincia'] = y_pred2
municipis_df.to_csv('Resultats_k-means_all.csv')


# Print clusters and save images
plt.figure(figsize=(10, 10))

plt.scatter(X[:, 0], X[:, 1], c = y_pred1)
plt.title("Municipis of Catalonia of more than 5000 unhab. grouped by 'Provincia'", fontsize = 20)

plt.savefig("k-means_provincies.png")

plt.figure(figsize=(10, 10))

plt.scatter(X_all[:, 0], X_all[:, 1], c = y_pred2)
plt.title("Municipis of Catalonia grouped by 'Provincia'", fontsize = 20)

plt.savefig("k-means_provincies_all.png")
