The code featured in this directory corresponds to figure S3, panel L. Files necessary to create this figure can be obtained from the locations listed below. R code to generage these figures is the same as Figure 2 panel G (https://github.com/Black-Lab-UCDenver/MTDNARereplication/blob/master/Figure2%20panel%20G/genomicTrack.r). Please note that Gviz can be difficult to install, and requires R version 3.6. Make sure you have Rcurl working and updated on your machine prior to instillation of Gviz. If you do choose to run the R program in this directory, please change the working directory in the code to the location of the input files.


The input files for this program include:

Human ChIP-seq data from GEO GSE179822 
Human CUT&RUN data from GEO GSE179823 
Human rerep-seq data from GEO GSE165865

ReplicationOrigins.bedgraph - Predicted origin data from MCF7 cells (Hansen et al., 2010) lifted over from hg19 to hg38 using UCSC liftover (https://genome.ucsc.edu/cgi-bin/hgLiftOver)

hg38.refGene.gtf - This file contains reference gene information from UCSC table browser (http://genome.ucsc.edu/cgi-bin/hgTables)

The output from the code will produce a genomic track image.

for figure S3 panel L use the following location data:

chromosome="chr12"
from=4239000
to=4354000
