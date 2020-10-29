

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
miR <- read.csv("../Data/MirWalk_Trimmed.csv", header=TRUE)

nt <- read.csv("../Data/MirWalk_Subset.csv", header=TRUE)


## FREQUENCY DISTRIBUTIONS
## Plot frequency distributions of mRNA targets per miRNA, and targeting miRNAs per mRNA
## Tabulate the miRWalk output and run a frequency distribution for mRNA-miR/miR-mRNA targeting stats

#View(miR)
summary(miR)
summary(miR$Gene)

#View(nt)
summary(nt)
summary(nt$Gene)

library(MASS)

## FULL SET HISTOGRAMS
##  histogram miRNA targets per mRNA

Gene = miR$Gene
Gene.freq = table(Gene)
GeneTable <- cbind(Gene.freq)
colors = c("lightgreen")
hist(GeneTable, freq=FALSE, main="miRNA Targets per mRNA: Density Plot", xlab = "# miRNAs targeting mRNA", breaks=50, col="lightgreen")
curve(dnorm(x, mean=mean(Gene.freq), sd=sd(Gene.freq)), add=TRUE, col="blue", lwd=2)

## histogram mRNAs targeted by miRNA

miRNA = miR$miRNA
miRNA.freq = table(miRNA)
miRTable <- cbind(miRNA.freq)
hist(miRTable, freq=FALSE, main = "mRNA targets per miRNA: Density Plot", xlab = "# of mRNAs targeted", breaks=20, col = "lightgreen")
curve(dnorm(x, mean=mean(miRNA.freq), sd=sd(miRNA.freq)), add=TRUE, col="blue", lwd=2)

## SUBSET HISTOGRAMS
## histogram miRNA targets per mRNA

Gene = nt$Gene
Gene.freq = table(Gene)
GeneTable <- cbind(Gene.freq)
colors = c("lightgreen")
hist(GeneTable, freq=FALSE, main="miRNA Targets per mRNA: Density Plot", xlab = "# miRNAs targeting mRNA", breaks=50, col="lightgreen")
curve(dnorm(x, mean=mean(Gene.freq), sd=sd(Gene.freq)), add=TRUE, col="blue", lwd=2)

## histogram mRNAs targeted by miRNA

miRNA = nt$miRNA
miRNA.freq = table(miRNA)
miRTable <- cbind(miRNA.freq)
hist(miRTable, freq=FALSE, main = "mRNA targets per miRNA: Density Plot", xlab = "# of mRNAs targeted", breaks=20, col = "lightgreen")
curve(dnorm(x, mean=mean(miRNA.freq), sd=sd(miRNA.freq)), add=TRUE, col="blue", lwd=2)


# head(nt)

## Visualize the complete bipartite graph
## https://rpubs.com/pjmurphy/317838
## Make a graph object from list
gNT <- graph.data.frame(nt)
gFULL <- graph.data.frame(miR)

## Make a graph g into a bipartite network
bipartite.mapping(gNT)
V(gNT)$type <- bipartite_mapping(gNT)$type
plot(gNT)
plot(gNT, vertex.label.cex = 1.0, vertex.label.color = "black")


## Format the labels and node shape/color
## Formatting for bipartite plots

V(gNT)$color <- ifelse(V(gNT)$type, "steelblue", "lightgreen")
V(gNT)$shape <- ifelse(V(gNT)$type, "circle", "square")
V(gNT)$label[V(gNT)$type==F] <- nodes2$media[V(net2)$type==F]
V(gNT)$label <- ""
E(gNT)$color <- "darkgrey"

plot(gNT, layout=layout.bipartite, vertex.label.cex=0.5, vertex.size=(2-V(gNT)$type)*8)

plot(gNT, layout=layout.bipartite)

plot(gNT, layout=layout.bipartite, vertex.size=20, vertex.label.cex=0.5)

V(gNT)$label.color <- "black" ##ifelse(V(g)$type, "black", "white")
## V(g)$label.font <-  0.6
V(gNT)$label.cex <- 1 ##ifelse(V(g)$type, 0.8, 1.2)
## V(g)$label.dist <-0
V(gNT)$frame.color <-  "gray"
V(gNT)$size <- 5

plot(gNT, layout = layout_with_graphopt)

plot(gNT, layout=layout.bipartite, vertex.size=20, vertex.label.cex=0.5)

## Save Plot to image
png("../Fig_Output/bipartite.png")
print(gNTplot)
dev.off()




## Analyze the network as a single-mode network
## According to https://rpubs.com/pjmurphy/317838

## Calculating centrality

types <- V(g)$type                 ## getting each vertex `type` let's us sort easily
deg <- degree(g)
bet <- betweenness(g)
clos <- closeness(g)
eig <- eigen_centrality(g)$vector

cent_df <- data.frame(types, deg, bet, clos, eig)

cent_df[order(cent_df$type, decreasing = TRUE),] ## sort w/ `order` by `type`

## Size vertices by centralitry
V(g)$size <- degree(g)
V(g)$label.cex <- degree(g) * 0.000000000000000000001

gplot <- plot(g, layout = layout_with_graphopt)

## Save the Graph plot as .png file into fig_output
png("../fig_output/graph.png")
print(gplot)
dev.off()

##NETWORK GRAPH
##Create and plot a network graph from the adjacency list

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
