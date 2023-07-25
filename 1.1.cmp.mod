param m; # m points
param d{1..m,1..m}; # distances/times/costs between pairs of points
param k; # k clusters

var x{1..m,1..m} binary;

minimize fobj: sum{i in 1..m,j in 1..m} d[i,j]*x[i,j];

subject to every_point_one_cluster {i in 1..m}: sum{j in 1..m} x[i,j]= 1;
subject to k_clusters: sum{j in 1..m} x[j, j] = k;
subject to existence {i in 1..m, j in 1..m}: x[j, j] >= x[i, j];

