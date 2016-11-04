library(GGally)
library(network)
library(sna)
library(ggplot2)
library(scales)


counts <- EDGE$count

net = network(EDGE, directed = TRUE)

ggnet2(net, size = .5,
       mode = "circle",
       color = "yellow",
       edge.size = .2,
       edge.color = adjustcolor("skyblue2", alpha.f = .5))

