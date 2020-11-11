<h1 align="center">
Analyze Networks and Pathways</h1>


Ms. Kathryn Hogan, BTEC 495 intern<br>
Dr. Jeffrey Robinson, BTEC 495 project adviser

The project is part of UMBC's BTEC495 Professional Internship and Project-based Research Experience, Ms. Hogan is a student in the [Translational Life Science Technology (TLST) program](http://shadygrove.umbc.edu/tlst.php) at Universities at Shady Grove Campus.

<h2 align="left">
Description of the project
</h2>

<h2 align="left">
Introduction
</h2>

  MicroRNAs are small non-coding RNAs that are known to perform many vital post-transcriptional regulatory steps of gene expression. MicroRNAs also play a role in many other cellular processes such as apoptosis, proliferation, or differentiation and perform regulation through either the inhibition of translation or the degradation of a transcript. Therefore, dysregulation of miRNAs may lead to a range of diseases.Continuing, the human genome encodes more than 200,000 transcripts and approximately 2,600 mature miRNAs. Hence, a single miRNA may target many different mRNAs and single mRNA may bind to various miRNAs, either simultaneously or in a context-dependent fashion. However, it is common for target regions of specific miRNAs to cluster together resulting in the cooperative repression effect. As a result, the mapping out of miRNA–mRNA interactions is notably difficult and far from being complete.

  Therefore, analysis of miRNA and mRNA interactions reveals insight into meaningful pathways and potentially new factors influencing a wide range of diseases. In a study performed by Robinson et al., data from the NCBI GEO database series GS132501 were subject to analyses in R studio to create visualizations of mRNA expression data from four miR-mimic treatments. The visualizations produced included clustering and principal components analysis (PCA), differential expression volcano plots, heatmaps of pathway scores, and miRNA biogenesis pathway results. The data analysis illustrated in this report represents results from the Advanced Analysis Module 2.0 plugin and Nanostring nSolver 4.0 software. 

  Furthermore, in another study performed by Robinson et al. a network model was developed that recognizes hypothetical co-regulatory motifs in a miRNA–mRNA interaction network. KEGG and miRWalk2.0 databases were utilized to create a list of mRNA-miRNA interactions that may play a role in the regulation of intestinal epithelial barrier function. In addition, an R-code was developed to aid the visualization and evaluation of these recorded interactions. Visualizations produced from this R-code include bar graphs, network plots, and a table. Robinson et al. describe in detail the attributes of this network and its most targeted genes and what the results may indicate, as well as the hypothetical role this miRNA-mRNA network plays. In addition, in a study performed by Joseph PV, et al., a signaling network was created after a miRNA mimic of each MetS-FL miR trio (hsa-miR-142-3p, hsa-miR-18b, hsa-miR-155, hsa-miR-890) was transfected into either CRL-1790 or Caco-2 human colorectal cells using a method known as lipofection. Researchers utilized Occludin and Zona Occludens-1/ZO-1 immunofluorescence staining-confocal microscopy, transepithelial electrical resistance (TEER), and nCounter® Human v3 miRNA, NanoString Technologies to evaluate alterations in the barrier and epithelial cell junction structure. Visualizations such as a network plot and the Log2 counts of untransfected cells were developed. Joseph PV, et al. describes changes in many miRNAs expression, structural modifications, as well as a signaling network associated with factors that are linked to injury, inflammation, and hyperplasia.
  
  Every miRNA utilized in these studies each have their own role in the body and are associated with different diseases. The first miRNA, miRNA 142 (hsa-miR-142-3p) is located on chromosome 17 in the region known as 17q22 and contains 1 exon. Within chromosome 17, miRNA 142 is located in the gene TSPOAP1-AS1, which contains 9 exons and is a ncRNA type gene.  In addition, the diseases asscoiated with miRNA 142 include Brain Cancer and Endometriosis. Second, miRNA 18b (hsa-miR-18b)is located on chromosome X in the region known as Xq26.2 and contains 1 exon. Within chromosome X, miRNA 18b is located next to microRNA 20b, that contains 1 exon and is a ncRNA type gene. The diseases associated with miRNA 18B include Multiple Sclerosis, Intrinsic Cardiomyopathy, and the Parkinson's Disease Pathway is also noted to be among the related pathways for miRNA 18b. Next, miRNA 155 (hsa-miR-155) is located on chromosome 21 in the region known as 21q21.3 and contains 1 exon. Within chromosome 21, miR 155 is located between the genes MIR155HG, LINC00515, and MRPL39. The diseases associated with miRNA 155 include Diffuse Large B-Cell Lymphoma and Pancreatic Ductal Adenocarcinoma. Finally, the last miRNA utilized in these studies is miRNA 890 (hsa-miR-890), and is located on chromosome X in the region known as Xq27.3 that contains 1 exon. Within chromosome X, miR890 is located next to microRNA 892a and microRNA 888, which both contains 1 exon and are ncRNA type genes. There are no diseases or pathways noted to be associated with miRNA 890.


  In this study, we aggregated data from the sources cited above as well as from the NCBI databases on human miRNA–mRNA interactions and then investigated how miRNAs target specific mRNAs of certain genes and the resulting networks of these interactions. In order to do this, we developed a code in R studio to further analyze these miRNA-mRNA interactions and develop visualizations to illustrate this network. The visualizations created to illustrate these interactions include density plots, bipartite mapping plots, and a bipartite-specific plot.


<h2 align="left">
Methods
</h2>

###### Nanostring Technologies

Nanostring Technologies, Inc. is a biotechnology company with a focus on developing cancer diagnostic tools. However, the company’s technology also enables a wide range of research with various applications in translational medicine. Moreover, Nanostring now has a wide variety of products ranging from gene expression analysis to microRNA analysis and highly multiplexed spatial profiling of RNA and protein targets. Additionally, Nanostring has developed the nCounter® Analysis System that provides a simple and cost-effective solution for multiplex analysis of up to 800 RNA, DNA, or protein targets from your precious samples. Nanostring Technologies hopes to provide leading institutions and researchers with the ideal tools to further their research and discoveries and translate them into clinically useful diagnostic tools.

###### Lipofection

Lipofection is a technique used to inject genetic material into a cell by means of liposomes. Liposomes are vesicles made up of a phospholipid bilayer making them more easily mergeable with the cell membrane. The standard protocol when performing lipofection using plasmid DNA starts with plating your cells at the appropriate density with medium and then incubating the cells. Following this, DNA plasmids must be prepped appropriately along with the desired reagent(s) and medium to create the transfection reagent. One finished, cells are transfected, typically in their existing growth medium and then placed back in the incubator. When performing transient transfection, the appropriate assay will then be performed to complete this process. On the other hand, if stable transfection is the goal then the transfected cells will continue to be grown and replated. Eventually, cloned colonies will be made and propagated for assay.

###### Centrality Metrics

In this study we utilized different centrality metrics to further analyze our data in R studio. These centrality metrics include degree, betweenness, closeness, and eigen_centrality. Each centrality metric reveals the different properities of a network and the nodes within that network. First,  The centrality metric degree calculates a score based on the number of links held by each node in a network. The degree tells us how many direct, ‘one-hop’ connections each node has to other nodes in a network. In addition, degree centrality is the simplest measure of node connectivity. Second, the centrality metric betweenness measures the number of times a node lies on the shortest path between other nodes. Betweenness shows which nodes are the ‘bridges’ between nodes in a network by identifying all the shortest paths and then counting the number of times each node falls on one. Third, the centrality metric closeness scores each node based on its closeness to all other nodes in the network, whether it be directly or indirectly. This measure calculates the shortest paths between all nodes, then assigns each node a score based on its sum of shortest paths. For finding the individuals who are best placed to influence the entire network most quickly. Finally, the centrality metric eigen Centrality, similar to degree centrality, measures the total number of adjacent nodes. However, eigen centrality also considers the importance of the adjacent nodes. The importance of a node is based on the number of links it has to other nodes in a network. Also, eigen centrality takes into account how well connected a node is, and how many links their connections have, and so on through the network. Essentially, eigen centrality calculates the extended connections of a node and can identify nodes with influence over the whole network, not just those directly connected to it.


<h2 align="left">
Results
</h2>

### Histograms: 

### miRNA Targets per mRNA: Density Plot
![](Fig_Output/Rplot.png)

### mRNA Targets per mRNA: Density Plot
![](Fig_Output/Rplot01.png)

### Bipartite Mapping:
| miRNAs Targeting Genes | miRNAs Targeting Genes in R |
  | --- | --- |
  | ![](Fig_Output/NetworkVis.png) | ![](Fig_Output/RploBPmap.png) |
  
  
<h2 align="left">  
Supporting Images
</h2>

### Graphics: 

### NanoString miRNA Hybridization
![](Fig_Output/NS_miRNA_protocol.jpg)


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


