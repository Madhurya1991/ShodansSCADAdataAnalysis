#install.packages("rjson")
#install.packages("jsonlite")

library("rjson")
#remove.packages("jsonlite")
library("jsonlite")
library("ggplot2")

setwd("D:/")
json_data <- stream_in(file("modbus.json"))

#str(json_data)
json_data_flat=flatten(json_data)

#json_dat.features=json_data_flat
#View(json_dat.features)


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



res <- kmeans(lat_lon,3,nstart=20)
resCluster <- as.factor(res$cluster)

library(fpc)
plotcluster(lat_lon,resCluster)

# library(rjson)
# setwd("d:/")
# jsonData <- fromJSON(file="bacnet_attr.json")
# #print(jsonData)
# 
# json_data_frame <- as.data.frame()
# 
# print(json_data_frame)

library(RJSONIO)
# from the websitne
setwd("d:/")
foodMarketsRaw<-fromJSON("ny.json")

foodMarkets <- foodMarketsRaw[['data']]

grabGeoInfo<-function(val){
  
  l<- length(foodMarkets[[1]][[val]])
  tmp<-lapply(1:l, function(y) 
    
    sapply(foodMarkets, function(x){
      
      if(!is.null(x[[val]][[y]])){
        return(x[[val]][[y]])
      }else{
        return(NA)
      }
      
    })     
  )
}


fmDataGeo<-grabGeoInfo(23)
fmDataGeo<-data.frame(do.call("cbind", fmDataGeo), stringsAsFactors=FALSE)

fmDataDF<-cbind(fmDataDF, fmDataGeo)

columns<-foodMarketsRaw[['meta']][['view']][['columns']]

fmNames1<-sapply(1:22, function(x) columns[[x]]$name)
fmNames2<-columns[[23]]$subColumnTypes

fmNames<-c(fmNames1, fmNames2)

names(fmDataDF)<-fmNames
head(fmDataDF)
#str(columns)
#str(foodMarkets[[1]][[23]])