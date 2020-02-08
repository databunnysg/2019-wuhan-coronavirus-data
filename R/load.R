library(jsonlite)
library(dplyr)
library(anytime)
library(readr)
library(ggplot2)
setwd("~/2019-wuhan-coronavirus-data/data-sources/dxy/data")
files<-list.files(path=".",pattern="*.json")
datetime<-files
datetime<- gsub(".json","",datetime)
datetime<- gsub("ncov-data","",datetime)
datetime<- gsub("dxy","",datetime)
datetime<- gsub("--2019","",datetime)
datetime<- gsub("-"," ",datetime)
datetime

#add none default datatime format to anytime library
addFormats(c("%Y%m%d %H%M%S"))


row<-data.frame()
for(i in 1:length(files))
{
  
  #ncovdf<- read_delim(files[i], 
  #           "|", escape_double = FALSE, trim_ws = TRUE, 
  #           skip = 2)
  ncovdf<-fromJSON(files[i])
  ncovdf$datetime<-anytime(datetime[i])
  ncovdf$cities<-NULL
  row<-bind_rows(row,ncovdf)
}


#ggplot(row,aes(datetime,confirmedCount))+geom_point(color=provinceName)
qplot(datetime,confirmedCount,data=row,color=provinceName)


