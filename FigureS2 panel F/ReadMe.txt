The code featured in this directory corresponds to figure 3, panels E-I. Files necessary to create this figure can be obtained from the locations listed below. R code to generage these figures is the same as Figure 2 panel G (https://github.com/Black-Lab-UCDenver/MTDNARereplication/blob/master/Figure2%20panel%20G/genomicTrack.r). Please note that Gviz can be difficult to install, and requires R version 3.6. Make sure you have Rcurl working and updated on your machine prior to instillation of Gviz. If you do choose to run the R program in this directory, please change the working directory in the code to the location of the input files.

The input files for this program include:

Human rerep-seq data from GEO GSE165865

Parental18MergedAveraged.50bp.10kbsmooth.bedgraph - This bedgraph contains the Rerep-seq coverage data for parental cells
Cad18MergedAveraged.50bp.10kbsmooth.bedgraph - This bedgraph contains the Rrerep-seq coverage data for cadmium treated cells
hg38.refGene.gtf - This file contains reference gene information from UCSC table browser (http://genome.ucsc.edu/cgi-bin/hgTables)

The output from the code will produce a genomic track image.