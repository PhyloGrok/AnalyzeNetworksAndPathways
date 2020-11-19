<h1 align="center">
Analyze Networks and Pathways</h1>

Dr. Jeffrey Robinson, BTEC 495 project supervisor<br>
Ms. Kathryn Hogan, BTEC 495 intern (Fall 2020)<br>

The project contains work performed by students from UMBC's BTEC495 Professional Internship and Project-based Research Experience as part of  [Translational Life Science Technology (TLST) program](http://shadygrove.umbc.edu/tlst.php) at Universities at Shady Grove Campus.

## I. Networks and Pathways

Bioinformatic analysis is key to the interpretation of -omics data.  Network and pathway analyses can elucidate the various functional molecular interactions occurring at the molecular and cellular level.  These analyses take many forms, in general the most common types of analyses for -omics data include:

<b>1. Molecular interaction networks.</b>  

A large abundance of yeast-2-hybrid data from the 2000's yielded the ability to model and validate proteome-scale protein-protein interaction networks.  More recently, during the 2010's, significant miRNA-mRNA interactions data has become available through methodologies around RNA-immunoprecipitation/RNA-seq studies ("RIP-seq").  Data on both bioinformatically predicted and experimentally validated miRNA-mRNA networks are available as large aggregated datasets from the MirWalk2.0 database.  

Both protein-protein and miRNA-mRNA interaction networks for data structures that lend themselves to analysis using Graph Theory mathematics.  While Graph Theory has seen hugely successful application to social networks analysis, it is less intesively applied to molecular interaction networks, and therefore development of such applications represents a growth area.

<b>2. Gene-ontology and pathway enrichment analysis.</b>

<b>3. Gene regulatory network analysis (ie. transcription regulatory networks).</b>

## II. Network analysis of miRNA-mRNA interaction networks
 
<b>A. Summarizing miRNA-mRNA interactions: Histograms.</b>

```
## Export the historgram as .png
png("../Fig_Output/H1.png")
H1 <- hist(miRTable, freq=FALSE, 
           main = "mRNA targets per miRNA: Density Plot", xlab = "# of mRNAs targeted", breaks=20, col = "lightgreen")

curve(dnorm(x, mean=mean(miRNA.freq), sd=sd(miRNA.freq)), add=TRUE, col="blue", lwd=2)
print(H1)
dev.off()
```

| mRNA <- miRNA        | miRNA <- mRNA           | 
| ------------- |:-------------:| 
| ![](Fig_Output/H1.png)      | ![](Fig_Output/H2.png) | 


##
### B. Visualizing Bipartite Networks: Plots
```

gNT <- graph.data.frame(nt)

gNT <- as.undirected(gNT, mode = c("collapse", "each", "mutual"),
                     edge.attr.comb = igraph_opt("edge.attr.comb"))

bipartite.mapping(gNT)

V(gNT)$type <- bipartite_mapping(gNT)$type

gNTplot <- plot(gNT)

gNTbipart <- plot(gNT, layout=layout.bipartite)

```
| Default        | Bipartite layout           | 
| ------------- |:-------------:| 
| ![](Fig_Output/gNTplot.png)      | ![](Fig_Output/gNTbipart.png) | 

```

types <- V(g)$type                 ## getting each vertex `type` let's us sort easily
deg <- degree(g)
bet <- betweenness(g)
clos <- closeness(g)
eig <- eigen_centrality(g)$vector

cent_df <- data.frame(types, deg, bet, clos, eig)
```



##
### Results of Bipartite Mapping

```

print(gNTplot)
dev.off()

types <- V(g)$type                 ## getting each vertex `type` let's us sort easily
deg <- degree(g)
bet <- betweenness(g)
clos <- closeness(g)
eig <- eigen_centrality(g)$vector

cent_df <- data.frame(types, deg, bet, clos, eig)
```


##

<h2 align="left">
Citations:
</h2>

Reinhold, et al. 2017. [The NCI-60 Methylome and its integration into CellMiner Database](https://cancerres.aacrjournals.org/content/77/3/601). Cancer Research. DOI: 10.1158/0008-5472.CAN-16-0655.

Reinhold, et al. 2012. CellMiner: A Web-Based Suite of Genomic and Pharmacologic Tools to Explore Transcript and Drug Patterns in the NCI-60 Cell Line Set. Cancer Research.72(14). DOI: 10.1158/0008-5472.CAN-12-1370. 

Chartrand G, Zhang P. 2012. A First Course in Graph Theory. Dover Publications, Inc. Mineola NY.

Joseph PV, et al. 2018. Colon Epithelial MicroRNA Network in Fatty Liver. Canadian Journal of Gastroenterology and Hepatology. 2018:8246103. PMID:30345259.

Lamouille S, Xu J, Derynck R. 2014. Molecular mechanisms of epithelial-mesenchymal transition. Nature Reviews Molecular Cell Biology. 15:179-196. 

Needham M, Hodler AE. 2019. Graph Algorithms Practical Examples in Apache Spark & Neo4j. O'REILLY. Boston MA.

Robinson JM. 2020. Differential gene expression and functional pathway enrichment in colon cell line CCD 841 CoN (CRL-1790) transfected with miR-mimics miR-18b, miR-142-3p, mir-155, and miR-890.  BioRxiv. DOI: http://dx.doi.org/10.1101/747931.

Robinson JM, Henderson WA. 2018. Modelling the structure of a ceRNA-theoretical, bipartite microRNA-mRNA interaction network regulating intestinal epithelial celluar pathways using R programming.  BMC Research Notes. 11:19. DOI: https://doi.org/10.1186/s13104-018-3126-y.

<h2 align="left">
Source code adapted for the project:
</h2>  

[Bipartite/Two-Mode Networks in igraph](https://rpubs.com/pjmurphy/317838)


