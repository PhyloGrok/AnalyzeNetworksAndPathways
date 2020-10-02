<h1 align="center">
Analyze Networks and Pathways</h1>


Ms. Kathryn Hogan, BTEC 495 intern<br>
Dr. Jeffrey Robinson, BTEC 495 project adviser

The project is part of UMBC's BTEC495 Professional Internship and Project-based Research Experience, Ms. Hogan is a student in the [Translational Life Science Technology (TLST) program](http://shadygrove.umbc.edu/tlst.php) at Universities at Shady Grove Campus.

<h2 align="left">
Description of the project
</h2>

Lipofection Summary 

Lipofection is a technique used to inject genetic material into a cell by means of liposomes. Liposomes are vesicles made up of a phospholipid bilayer making them more easily mergeable with the cell membrane. The standard protocol when performing lipofection using plasmid DNA starts with plating your cells at the appropriate density with medium and then incubating the cells. Following this, DNA plasmids must be prepped appropriately along with the desired reagent(s) and medium to create the transfection reagent. One finished, cells are transfected, typically in their existing growth medium and then placed back in the incubator. When performing transient transfection, the appropriate assay will then be performed to complete this process. On the other hand, if stable transfection is the goal then the transfected cells will continue to be grown and replated. Eventually, cloned colonies will be made and propagated for assay. 

 
Nanostring Summary 

Nanostring Technologies, Inc. is a biotechnology company with a focus on developing cancer diagnostic tools. However, the company’s technology also enables a wide range of research with various applications in translational medicine. Moreover, Nanostring now has a wide variety of products ranging from gene expression analysis to microRNA analysis and highly multiplexed spatial profiling of RNA and protein targets. Additionally, Nanostring has developed the nCounter® Analysis System that provides a simple and cost-effective solution for multiplex analysis of up to 800 RNA, DNA, or protein targets from your precious samples. Nanostring Technologies hopes to provide leading institutions and researchers with the ideal tools to further their research and discoveries and translate them into clinically useful diagnostic tools. 

100 Word Summary Robinson 2020

Data from the NCBI GEO database series GS132501 was utilized in this report to create analyses and visualizations of mRNA expression data from four miR-mimic treatments. The bioinformatic methods utilized include pathway scoring, differential expression (DE), and gene-set enrichment (GSE) analyses. The visualizations produced include clustering and principal components analysis (PCA), differential expression volcano plots, heatmaps of pathway scores, and miRNA biogenesis pathway results. The data analysis illustrated in this report represents results from the Advanced Analysis Module 2.0 plugin and Nanostring nSolver 4.0 software. Additionally, this report describes the various miRNA mimics utilized in this bioinformatic analysis as well as the scientific evidence supporting the appropriateness of their use.



100 Word Summary Robinson 2018

In this study, a network model was developed to recognize hypothetical co-regulatory motifs in a miRNA–mRNA interaction network. KEGG and miRWalk2.0 databases were utilized in this study to create a list of mRNA-miRNA interactions that may play a role in the regulation of intestinal epithelial barrier function. In addition, an R-code was developed to aid the visualization and evaluation of these recorded interactions. Visualizations produced from this study include bar graphs, network plots, and a table. This study describes in detail the attributes of this network and its most targeted genes and what the results may indicate, as well as the hypothetical role this network plays.


100 Word Summary Joseph et al. 2018

In this study, a signaling network was created after a miR mimic of each MetS-FL miR trio (hsa-miR-142-3p, hsa-miR-18b, and hsa-miR-890) was transfected into either CRL-1790 or Caco-2 human colorectal cells. Researchers utilized Occludin and Zona Occludens-1/ZO-1 immunofluorescence staining-confocal microscopy, transepithelial electrical resistance (TEER), and nCounter® Human v3 miRNA, NanoString Technologies to evaluate alterations in the barrier and epithelial cell junction structure. Visualizations such as a network plot and the Log2 counts of untransfected cells were developed. This study describes changes in many miRs expression, structural modifications, as well as a signaling network associated with factors that are linked to injury, inflammation, and hyperplasia.



<h2 align="left">
Results
</h2>

### Histograms: 

### miRNA Targets per mRNA: Density Plot
![](Fig_Output/Rplot.png)

### mRNA Targets per mRNA: Density Plot
![](Fig_Output/Rplot01.png)


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


