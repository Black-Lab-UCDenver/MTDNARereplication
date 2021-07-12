The code featured in this directory corresponds to figure S2, panel F. Files necessary to create this figure can be obtained from the locations listed below. R code to generage these figures is the same as Figure 2 panel G (https://github.com/Black-Lab-UCDenver/MTDNARereplication/blob/master/Figure2%20panel%20G/genomicTrack.r). Please note that Gviz can be difficult to install, and requires R version 3.6. Make sure you have Rcurl working and updated on your machine prior to instillation of Gviz. If you do choose to run the R program in this directory, please change the working directory in the code to the location of the input files.

The input files for this program include:

Human rerep-seq data from GEO GSE165865

hg38.refGene.gtf - This file contains reference gene information from UCSC table browser (http://genome.ucsc.edu/cgi-bin/hgTables)

The output from the code will produce a genomic track image.

![alt text](https://github.com/Black-Lab-UCDenver/MTDNARereplication/blob/master/images/sup2F.png?raw=true)

for figure S2 panel F use the following location data:
chromosome="chr16"
from=46400000 
to=90300000
