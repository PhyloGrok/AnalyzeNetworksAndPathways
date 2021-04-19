## Comment the code
## Install packages
if (!require("rstudioapi")) {
  install.packages("rstudioapi", dependencies = TRUE)
  library(rstudioapi)
}

if (!require("ggplot2")) {
  install.packages("ggplot2", dependencies = TRUE)
  library(ggplot2)
}

if (!require("MASS")) {
  install.packages("MASS", dependencies = TRUE)
  library(MASS)
}

if (!require("Matrix")) {
  install.packages("Matrix", dependencies = TRUE)
  library(Matrix)
}

if (!require("igraph")) {
  install.packages("igraph", dependencies = TRUE)
  library(igraph)
}

# Set working directory to source file location
setwd(dirname(getActiveDocumentContext()$path))       

#Read .csv file into R data
miR <- read.csv("../Data/FULL.csv", header=TRUE)

nt <- read.csv("../Data/SUBSET.csv", header=TRUE)

## Part 1:
## FREQUENCY DISTRIBUTIONS
## Plot frequency distributions of mRNA targets per miRNA, and targeting miRNAs per mRNA
## Tabulate the miRWalk output and run a frequency distribution for mRNA-miR/miR-mRNA targeting stats

#View(miR)
summary(miR)
summary(nt)

## FULL SET HISTOGRAMS
##  histogram miRNA targets per mRNA

Gene = miR$Gene
Gene.freq = table(Gene)
GeneTable <- cbind(Gene.freq)
colors = c("lightgreen")

png("../Fig_Output/H1.png")
H1 <- hist(GeneTable, freq=FALSE, 
           main="miRNA Targets per mRNA: Density Plot", xlab = "# miRNAs targeting mRNA", breaks=50, col="lightgreen")

curve(dnorm(x, mean=mean(Gene.freq), sd=sd(Gene.freq)), add=TRUE, col="blue", lwd=2)
print(H1)
dev.off()

## histogram mRNAs targeted by miRNA

miRNA = miR$miRNA
miRNA.freq = table(miRNA)
miRTable <- cbind(miRNA.freq)
colors = c("lightgreen")

png("../Fig_Output/H2.png")
H2 <- hist(miRTable, freq=FALSE, 
           main = "mRNA targets per miRNA: Density Plot", xlab = "# of mRNAs targeted", breaks=20, col = "lightgreen")

curve(dnorm(x, mean=mean(miRNA.freq), sd=sd(miRNA.freq)), add=TRUE, col="blue", lwd=2)
print(H2)
dev.off()

## Visualize the complete bipartite graph
## https://rpubs.com/pjmurphy/317838
## Make a graph object from list
gNT <- graph.data.frame(nt)
gFULL <- graph.data.frame(miR)

## Eliminate the arrowheads. (the graph is assigned as a directed)
## (https://igraph.org/r/doc/as.directed.html)

gNT <- as.undirected(gNT, mode = c("collapse", "each", "mutual"),
                     edge.attr.comb = igraph_opt("edge.attr.comb"))

gFULL <- as.undirected(gFULL, mode = c("collapse", "each", "mutual"),
                     edge.attr.comb = igraph_opt("edge.attr.comb"))

## Simplify and make a graph gNT into a bipartite network

bipartite.mapping(gNT)
V(gNT)$type <- bipartite_mapping(gNT)$type

bipartite.mapping(gFULL)
V(gFULL)$type <- bipartite_mapping(gFULL)$type

#plot(gNT)
#plot(gNT, vertex.label.cex = 1.0, vertex.label.color = "black")

## Format the labels and node shape/color
## Formatting for bipartite plots
##  https://kateto.net/netscix2016.html

V(gNT)$color <- ifelse(V(gNT)$type, "steelblue", "lightgreen")
V(gNT)$shape <- ifelse(V(gNT)$type, "circle", "square")

V(gNT)$color <- c("orange", "steelblue")[V(gNT)$type+1]
V(gNT)$shape <- c("square", "circle")[V(gNT)$type+1]
V(gNT)$label.cex <- c(0.0001, 0.6)[V(gNT)$type+1]
V(gNT)$size <- c(3, 20)[V(gNT)$type+1]

plot(gNT)
png("../Fig_Output/gNTplot.png")

tiff("../Fig_Output/gNTplot.tiff", units="in", width=7, height=7, res=1000, compression = 'lzw')
gNTplot <- plot(gNT)
print(gNTplot)
dev.off()



plot(gNT, layout=layout.bipartite)
png("../Fig_Output/gNTbipart.png")
tiff("../Fig_Output/gNTbipart.tiff", units="in", width=7, height=7, res=1000, compression = 'lzw')
gNTplot <- plot(gNT, layout=layout.bipartite)
print(gNTplot)
dev.off()

##FullGraph
V(gFULL)$color <- c("orange", "steelblue")[V(gFULL)$type+1]
V(gFULL)$shape <- c("square", "circle")[V(gFULL)$type+1]
V(gFULL)$label.cex <- c(0.0001, 0.1)[V(gFULL)$type+1]
V(gFULL)$size <- c(1.5, 3)[V(gFULL)$type+1]

plot(gFULL)
png("../Fig_Output/gFULLplot.png")
tiff("../Fig_Output/gFULLplot.tiff", units="in", width=7, height=7, res=1000, compression = 'lzw')

gFULLplot <- plot(gFULL)
print(gFULLplot)
dev.off()

plot(gFULL, layout=layout.bipartite)
png("../Fig_Output/gFULLbipart.png")
tiff("../Fig_Output/gFULLbipart.tiff", units="in", width=7, height=7, res=1000, compression = 'lzw')

gFULLplot <- plot(gFULL, layout=layout.bipartite)
print(gNTplot)
dev.off()

## Analyze the network as a single-mode network
## According to https://rpubs.com/pjmurphy/317838

## Generate centrality metrics for each graph and export data
## https://www.youtube.com/watch?v=WjpcbmcJjjM

## Subset graph
types <- V(gNT)$type  ## getting each vertex `type` lets us sort easily
deg <- degree(gNT)
bet <- betweenness(gNT)
clos <- closeness(gNT)
eig <- eigen_centrality(gNT)$vector

subsetTable <- data.frame(types, deg, bet, clos, eig)
subsetTable[order(subsetTable$type, decreasing = TRUE),] ## sort w/ `order` by `type`
write.table(subsetTable, file="../Data_Output/SubsetTable.csv", sep=",", col.names = NA)

## Full graph
types <- V(gFULL)$type
deg <- degree(gFULL)
bet <- betweenness(gFULL)
clos <- closeness(gFULL)
eig <- eigen_centrality(gFULL)$vector

fullTable <- data.frame(types, deg, bet, clos, eig)
fullTable[order(fullTable$type, decreasing = TRUE),]
write.table(fullTable, file="../Data_Output/FullTable.csv", sep=",", col.names = NA)

## Boxplots
library(ggplot2)
Results <- read.csv("../Data/CentralityResults.csv", header=TRUE)
summary(Results)
#Results$graph <- as.factor(Results$graph)

## http://www.sthda.com/english/wiki/ggplot2-box-plot-quick-start-guide-r-software-and-data-visualization


png("../Fig_Output/degPlot.png")
#tiff("../Fig_Output/degPlot.tiff", units="in", width=7, height=7, res=1000, compression = 'lzw')

degPlot <- ggplot(Results, aes(x=molecule, y=degree, fill=graph)) + 
  geom_boxplot(outlier.shape=NA)
print(degPlot)
dev.off()

png("../Fig_Output/betPlot.png")
#tiff("../Fig_Output/betPlot.tiff", units="in", width=7, height=7, res=1000, compression = 'lzw')

betPlot <- ggplot(Results, aes(x=molecule, y=betweeness, fill=graph)) + 
  geom_boxplot(outlier.shape=NA)
print(betPlot)
dev.off()

png("../Fig_Output/closePlot.png")
#tiff("../Fig_Output/closePlot.tiff", units="in", width=7, height=7, res=1000, compression = 'lzw')

closePlot <- ggplot(Results, aes(x=molecule, y=closeness, fill=graph)) + 
  geom_boxplot(outlier.shape=NA)
print(closePlot)
dev.off()

png("../Fig_Output/eigPlot.png")
#tiff("../Fig_Output/eigPlot.tiff", units="in", width=7, height=7, res=1000, compression = 'lzw')

eigPlot <- ggplot(Results, aes(x=molecule, y=eigenCentrality, fill=graph)) + 
  geom_boxplot(outlier.shape=NA)
print(eigPlot)
dev.off()

## Size vertices by centrality
V(gNT)$size <- degree(gNT) * .2
V(gNT)$label.cex <- degree(gNT) * 0.005
plot(gNT, layout = layout_with_graphopt)
plot(gNT, layout = layout.bipartite)
plot(gNT)
gplot <- plot(gNT, layout = layout_with_graphopt)

V(gFULL)$size <- degree(gFULL) * .2
V(gFULL)$label.cex <- degree(gFULL) * 0.005
plot(gFULL, layout = layout_with_graphopt)
plot(gFULL, layout = layout.bipartite)
gplot <- plot(gNT, layout = layout_with_graphopt)

## Save the Graph plot as .png file into fig_output
png("../fig_output/graph.png")
print(gplot)
dev.off()

##Bipartite X- and Y-projections
##Create and plot a network graph from the adjacency list
##Adapted from Robinson & Henderson, 2018

#Convert into data frame
miRFrame <- data.frame(person=miR$Gene, gr=miR$miRNA, stringsAsFactors = F)

##Treat the adjacenty list as a bipartite network (coding genes and miRNAs each constitute the two bipartite modes of the network).
##Code was derived from social network modelling from the blog of Solomon Messing.
##https://solomonmessing.wordpress.com/2012/09/30/working-with-bipartiteaffiliation-network-data-in-r/

#Use functions from the R Matrix package to create an adjacency matrix 'A' from the imported list.
library(Matrix)

A <- spMatrix(nrow=length(unique(miRFrame$person)),
              ncol=length(unique(miRFrame$gr)),
              i = as.numeric(factor(miRFrame$person)),
              j = as.numeric(factor(miRFrame$gr)),
              x = rep(1, length(as.numeric(miRFrame$person))) )

row.names(A) <- levels(factor(miRFrame$person))
colnames(A) <- levels(factor(miRFrame$gr))
A

Arow <- tcrossprod(A)
Arow
head(Arow)

##Use the R Igraph package to create a network graph object.
library(igraph)

miRgraphAdj <- graph.adjacency(Arow, mode = 'undirected')
summary(miRgraphAdj)

##make each edge weight become 1, and then sum them back into an edge attribute
#http://stackoverflow.com/questions/12998456/r-igraph-convert-parallel-edges-to-weight-attribute
E(miRgraphAdj)$weight
E(miRgraphAdj)$weight <- 1
miRgraphAdj <- simplify(miRgraphAdj, edge.attr.comb=list(weight="sum"))

E(miRgraphAdj)$width <- E(miRgraphAdj)$weight
E(miRgraphAdj)$width
# direct output to a file
sink("EdgeFile", append=FALSE, split=FALSE)

##Assign vertex label attributes, color and font
V(miRgraphAdj)$label <- V(miRgraphAdj)$name
V(miRgraphAdj)$label.color <- rgb(0,0,.2,.8)
V(miRgraphAdj)$label.cex <- .6
V(miRgraphAdj)$label.cex <- .3
V(miRgraphAdj)$label.font <- 1
V(miRgraphAdj)$color <- rgb(1,0,0,.5)

miRgraphAdj <- simplify(miRgraphAdj, remove.loops = TRUE, remove.multiple = TRUE)

##Assign transparency as a function of Edge weight
egam <- (E(miRgraphAdj)$weight)/max(E(miRgraphAdj)$weight)
E(miRgraphAdj)$color <- rgb(.5,.5,0,egam)

##Plot the graph object, with vertex size as a function of 'betweeness' and edge width a function of edge weight.
##Apply scaling functions to create resolution for visual interpretation of the graph.
##Here, the user-derived betweeness(mirgraphAdj/33) and log(E(miRgraphAdj)$weight) were user-derived to reduce the 'hairball' and facilitate interpretation
plot(miRgraphAdj, vertex.size=betweenness(miRgraphAdj)/33, edge.width=log10(E(miRgraphAdj)$weight), layout=layout.kamada.kawai)


##For scaling vertex.size and edge widths for different graphs:
##plot(miRgraphAdj, vertex.size=betweenness(miRgraphAdj)/V_Scaling_Factor, edge.width=E_Scaling_Factor(E(miRgraphAdj)$weight), layout=layout.kamada.kawai)

##For the 5-gene subgraph found in Fig.3C (Input file 'Subset.R'):
plot(miRgraphAdj, vertex.size=20, edge.width=(E(miRgraphAdj)$weight)/10, layout=layout.fruchterman.reingold)
