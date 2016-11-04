library(dplyr)
library(tidyr)
library(igraph)

setwd("~/R/CitiBike Data")
dataset <- read.csv("2013-07 - Citi Bike trip data.csv", header = TRUE)
setwd("~/GitHub/CitiBike")

D1 <- dataset

## Added strptime to correct unambiguous data format error ##

D1$starttime <- as.POSIXct(D1$starttime, format = "%Y-%m-%d %H:%M:%S", tz = "EST")

D2 <- filter(D1, starttime >= "2013-07-01 00:00:00" & starttime <= "2013-07-01 23:59:59")

EDGE <- select(D2, start.station.id, end.station.id)
EDGE$count <- 1

EDGE <- EDGE %>% group_by(start.station.id, end.station.id) %>% summarise(sum(count))

names(EDGE) <- c("to", "from", "count")

START <- as.data.frame(EDGE$from)
names(START) <- c("station")

END <- as.data.frame(EDGE$to)
names(END) <- c("station")

VERT <- rbind(START, END)

VERT <- unique(VERT)

g <- graph.data.frame(EDGE, directed=TRUE, vertices=VERT)


g <- graph.data.frame(EDGE, directed=TRUE, vertices=VERT)


## Chad Code
count <- EDGE$count
plot(g, layout=layout.fruchterman.reingold(g),
     edge.arrow.size=.1,
     vertex.size=3, 
     vertex.color=adjustcolor("yellow", alpha.f = .8), 
     vertex.label=NA,
     edge.color=adjustcolor("skyblue2", alpha.f = c()))
