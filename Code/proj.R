install.packages("rjson")
library("rjson")
library("jsonlite")


library("sparklyr")
spark_install(version = "1.6.2")
if (nchar(Sys.getenv("SPARK_HOME")) < 1) {
  Sys.setenv(SPARK_HOME = "/home/spark")
}
library(SparkR, lib.loc = c(file.path(Sys.getenv("SPARK_HOME"), "R", "lib")))
sparkR.session(master = "local[*]", sparkConfig = list(spark.driver.memory = "2g"))

setwd("D:/MadhuryaMSnotes/4_Sem_MS/BigData/ProjectMaterial/modbus.json/")
json_data <- stream_in(file("modbus.json"))
#json_data <-fromJSON("modbus.json")

str(json_data)
json_data_flat=flatten(json_data)
df <- as.DataFrame(json_data_flat)
#json_dat.features=json_data_flat
#View(json_dat.features)

mydata3 <- na.omit(json_data_flat[3])
mydata4
mydata4 <- na.omit(json_data_flat[26])

mydata1 <- na.omit(json_data_flat[19])
mydata2 <- na.omit(json_data_flat[25]) # listwise deletion of missing

#mydata <- scale(json_data_flat[19]) # standardize variables
#mydata <- scale(json_data_flat[25]) # standardize variables

typeof(mydata)
mydata

#lat_clean <- lapply(json_data_flat[19] , function(x) x[!is.na(x)])
#lon_clean <- lapply(json_data_flat[25] , function(x) x[!is.na(x)])

lat <-as.matrix(mydata1)
lon <- as.matrix(mydata2)
lat_lon <- cbind(lat,lon)
lat_lon

res_time <- kmeans(mydata3,7,nstart=20)
res1 <- knn
res <- kmeans(lat_lon,7,nstart=100)

install.packages('fpc') ; library(fpc)
library(cluster)
library(fpc)
plotcluster(lat_lon, res$cluster)


#version


