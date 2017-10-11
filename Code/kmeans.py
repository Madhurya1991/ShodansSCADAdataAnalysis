# -*- coding: utf-8 -*-
"""
Created on Thu Dec  8 01:07:48 2016

@author: Keerthi Bala Sundram
"""
import json
import numpy as np
import matplotlib.pyplot as plt
from matplotlib import style
style.use("ggplot")
from sklearn.cluster import KMeans


longitude = []
latitude = []
location = []
timestamp = []
ipaddress = []

data_file = "D:/MadhuryaMSnotes/4_Sem_MS/BigData/ProjectMaterial/siemens-s7.json/siemens.json" 
ind_data = []
with open(data_file) as f:
  for line in f:
   ind_data.append(json.loads(line))

for item in ind_data:
    location.append(item[u'location'])


for item in ind_data:
  location.append(item[u'location'])
  timestamp.append(item[u'timestamp'])
  ipaddress.append(item[u'ip_str'])



for x in location:
    if(x['latitude'] and x['longitude'] != None):
        latitude.append(x['latitude'])
        longitude.append(x['longitude'])
    
    
arr=np.column_stack((latitude,longitude))    
kmeans = KMeans(n_clusters=4)
kmeans.fit(arr)

centroids = kmeans.cluster_centers_
labels = kmeans.labels_

#print(centroids)
#print(labels)
		

colors = ["g.","r.","c.","y."]
X=arr

for i in range(len(X)):
  #  print("coordinate:",X[i], "label:", labels[i])
    plt.plot(X[i][0], X[i][1], colors[labels[i]], markersize = 10)

plt.scatter(centroids[:, 0],centroids[:, 1], marker = "x", s=150, linewidths = 5, zorder = 10)

plt.show()
    
