library(igraph)
library(sna)
library(network)
library(ndtv)
library(dplyr)
library(tidyr)
library(gridExtra)

# - - -- - Load Data

setwd("~/R/CitiBike Data")
dataset <- read.csv("201609-citibike-tripdata.csv")
setwd("~/GitHub/CitiBike")

df_2016 <- dataset
df_2016$starttime <- as.POSIXct(df_2016$starttime, format = "%m/%d/%Y %H:%M:%S", tz = "EST")

df <- filter(df_2016, starttime >= "2016-09-01 00:00:00" & starttime <= "2016-09-01 23:59:59")

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
df1 <- df1 %>% group_by(start.station.id, end.station.id) %>% summarise(sum(weight))
names(df1) <- c("from","to","weight")

head(station_id1)
head(df1)
nrow(station_id1); length(unique(station_id1$station_id))
nrow(df1); nrow(unique(df1[,c("from", "to")]))

df1 <- df1[order(df1$from, df1$to),]
rownames(df1) <- NULL

net <- graph.data.frame(df1, station_id1, directed = T, vertices=VERT)
net <- simplify(net, remove.multiple = F, remove.loops = T) 
E(net)$weight <- edge.betweenness(net)
plot(net,
     layout=layout.circle(net),
     edge.arrow.size=.1,
     vertex.size=1.5, 
     vertex.color="yellow", 
     edge.color=adjustcolor("skyblue2", alpha.f = .3),
     edge.width=df1$weight*.01,
     vertex.label=NA)
