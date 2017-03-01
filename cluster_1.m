Q=[x',y'];
Y1=pdist(Q);
Z1=linkage(Y1,'average');
%dendrogram(Z1);
c1=cophenet(Z1,Y1);
T=cluster(Z1,'maxclust',3);