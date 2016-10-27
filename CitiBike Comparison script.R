library(igraph)
library(sna)
library(network)
library(ndtv)

# - - -- - Load Data

setwd("~/R/CitiBike Data")
df <- read.csv("201609-citibike-tripdata.csv")
setwd("~/GitHub/CitiBike")

# - - - - - - - - Extract Node Data

start_station <- df[!duplicated(df["start.station.id"]),]
end_station <- df[!duplicated(df["end.station.id"]),]

start_station1 <- subset(start_station, select = c("start.station.id","start.station.name","start.station.latitude","start.station.longitude"))
end_station1 <- subset(end_station, select = c("end.station.id","end.station.name","end.station.latitude","end.station.longitude"))

names(start_station1) <- c("station_id","station_name","station_latitude","station_longitude")
names(end_station1) <- c("station_id","station_name","station_latitude","station_longitude")

station_id <- rbind(start_station1, end_station1)
station_id1 <- station_id[!duplicated(station_id["station_id"]),]


df1 <- subset(df, select = c("start.station.id", "end.station.id"))
df1$weight <- 1
names(df1) <- c("from","to","weight")

head(station_id1)
head(df1)
nrow(station_id1); length(unique(station_id1$station_id))
nrow(df1); nrow(unique(df1[,c("from", "to")]))

df2 <- aggregate(df1[,3], df1[,-3], sum)
df2 <- df2[order(df2$from, df2$to),]
colnames(df2)[3] <- "weight"
rownames(df2) <- NULL


net <- graph.data.frame(df2, station_id1, directed = T)
net <- simplify(net1, remove.multiple = F, remove.loops = T) 

plot(net) 
