install.packages("bipartite")

library(bipartite)



#Use functions from the R Matrix package to create an adjacency matrix 'A' from the imported list.
library(Matrix)

miR <- read.csv("MiRWalk_Trimmed.csv")

#Convert into data frame
miRFrame <- data.frame(person=miR$Gene, gr=miR$miRNA, stringsAsFactors = F)

## Convert adjacency list to adjacency
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


summary(motten1982)
View(motten1982)

par(xpd=T)
plotweb(motten1982)
visweb(motten1982)

plotPAC(PAC(motten1982), outby=0.9)

mod <- computeModules(motten1982)
plotModuleWeb(mod)

par(mfrow=c(1,2), xpd=T)

gplot(as.one.mode(motten1982, project="higher"),
      label=colnames(motten1982), gmode="graph",
      label.cex=0.6, vertex.cex=2)

gplot(as.one.mode(motten1982, project="lower"),
      label=rownames(motten1982), gmode="graph",
      label.cex=0.6, vertex.cex=2, vertex.col="green")

## fine tuning networklevel
networklevel(bezerra2009, index=c("ISA", "weighted NODF", "Fisher alpha"),
             SAmethod="log")

## grouplevel can comprise the list of desired indices + options, as well as levels for which the computation shall be carried out
grouplevel(bezerra2009, level="both", index=c("mean number of links", "weighted
                                              cluster coefficient", "effective partners", "niche overlap"), dist="bray")

## linklevel: employed for indices/indexes to be investigated at individual link
str(linklevel(bezerra2009, index=c("dependence", "endpoint")))

## specieslevel: comprise the list of desired indices and options and levels for which the computation shall be carried out
specieslevel(bezerra2009, level="lower", index=c("normalised degree", "PDI",
                                                 "effective partners"), PDI.normalise=F)
install.packages("igraph")
library(igraph)
install.packages("tnet")
library(tnet)
install.packages("DiagrammeR")
library(DiagrammeR)
install.packages("influenceR")
library(influenceR)

## Betweenness: a graph index which quantifies the importance of a node for fluxes between nodes. Count how many of all shortest paths between 2 nodes go through the target node. 
## a peripheral node will have a betweenness score of 0, while a central node can have up to n (if all shortest paths go through it)
data(Safariland)
# plot the one-mode projection for the lower level:
set.seed(4) # don't ask me why gplot is stochastic ...
par(xpd=T, mar=c(0,6,0,6))
gplot(as.one.mode(Safariland, project="lower"), label=rownames(Safariland))

## Get betweeness scores: 
# convert matrix into one-mode edgelist:
SafPlantsEL <- as.tnet(as.one.mode(Safariland, project="lower"))

# compute betweenness:
tnet::betweenness_w(SafPlantsEL) # 6
bipartite::BC(Safariland, rescale=F)$lower # 6
DiagrammeR::get_betweenness(DiagrammeR::from_igraph(tnet_igraph(SafPlantsEL))) # 6
igraph::betweenness(tnet_igraph(SafPlantsEL), cutoff=9) # 6
influenceR::betweenness(tnet_igraph(SafPlantsEL)) # 12
sna::betweenness(SafPlantsEL) # length 36!!
sna::betweenness(as.matrix(SafPlantsEL)) # length 27!!


btws <- cbind("t:betw"=tnet::betweenness_w(SafPlantsEL)[,2],
              "b:BC"=bipartite::BC(Safariland,  rescale=F)$lower,
              "DR:betw"=DiagrammeR::get_betweenness(DiagrammeR::from_igraph(tnet_igraph(SafPlantsEL))),
              "i:estbetw"=igraph::betweenness(tnet_igraph(SafPlantsEL), cutoff=9),
              "inf:betw"=influenceR::betweenness(tnet_igraph(SafPlantsEL))/2)
                                                                              
rownames(btws) <- rownames(Safariland)
btws


web.names <- data(package="bipartite")$results[,3]
data(list=web.names) 
# the next step takes around 10 minutes:
netw.indic.webs <- t(sapply(web.names, function(x) networklevel(get(x),
                                                                index="ALLBUTDD")))
PCA.out <- prcomp(netw.indic.webs[,-5], scale.=T)
biplot(PCA.out, xpd=T, las=1)
summary(PCA.out)
round(PCA.out$rotation[, 1:4], 3)

install.packages("Hmisc")
library(Hmisc)
plot(varclus(netw.indic.webs), cex=0.8)
abline(h=0.5, lty=2, col="grey")

## Use null models to test for significant tests in data
data(Safariland)
Iobs <- nestednodf(Safariland)$statistic[3]
nulls <- nullmodel(web=Safariland, N=1000, method='r2d') # takes a while!
Inulls <- sapply(nulls, function(x) nestednodf(x)$statistic[3])
plot(density(Inulls), xlim=c(0, 100), lwd=2, main="NODF")
abline(v=Iobs, col="red", lwd=2)

## Null model the entire analysis
weblist <- lapply(c("Safariland", "vazarr", "vazllao", "vazcer", "vazmasc",
                    "vazmasnc", "vazquec", "vazquenc"), get)
# Write a function to compute the desired statistic, e.g. the difference
# between grazed and ungrazed:
meandiff <- function(webs){
  obs <- sapply(webs, networklevel, index="linkage density")
  mean(obs[1:4]) - mean(obs[5:8])
  }
(observed <- meandiff(weblist))

nulllist <- lapply(weblist, nullmodel, N=1, method="r2d")
meandiff(weblist)

##repeat the process 500 times
res <- 1:5000
for (i in 1:5000){ # takes a few minutes !!
  nulllist <- sapply(weblist, nullmodel, N=1, method="r2d")
  res[i] <- meandiff(nulllist)
  }

hist(res, xlim=c(-0.3, 0.3), border="white", col="grey")
abline(v=observed, col="red", lwd=2)
# compute p-value as proportion smaller or than observed
sum(res < observed)/length(res) * 2 # *2 for two-tailed test

