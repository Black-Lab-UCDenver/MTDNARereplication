The code featured in this directory corresponds to figure 2, panel G. Files necessary to create this figure can be obtained from the locations listed below. Please note that Gviz can be difficult to install, and requires R version 3.6. Make sure you have Rcurl working and updated on your machine prior to instillation of Gviz. If you do choose to run the R program in this directory, please change the working directory in the code to the location of the input files.

The input files for this program include:

Human rerep-seq data from GEO GSE165865

parental.rpmMito.50bpBin.10kbsmooth.bedgraph - This bedgraph contains the Rerep-seq coverage data for parental cells
cad75.rpmMito.50bpBin.10kbsmooth.bedgraph - This bedgraph contains the Rrerep-seq coverage data for cadmium treated cells
hg38.refGene.gtf - This file contains reference gene information from UCSC table browser (http://genome.ucsc.edu/cgi-bin/hgTables)

The output from the code will produce a genomic track image.

# for figure 2 panel F use the following location data:
chromosome="chr16"
from=46400000 
to=90300000

![alt text](https://github.com/Black-Lab-UCDenver/MTDNARereplication/blob/master/images/Figure2G.png?raw=true)
