The code featured in this directory corresponds to figure S7, panel C. Files necessary to create this figure can be obtained from the locations listed below. R code to generage these figures is the same as Figure 7 panel B (https://github.com/Black-Lab-UCDenver/MTDNARereplication/blob/master/Figure7/7%20panel%20B/YeastTracks.r). Please note that Gviz can be difficult to install, and requires R version 3.6. Make sure you have Rcurl working and updated on your machine prior to instillation of Gviz. If you do choose to run the R program in this directory, please change the working directory in the code to the location of the input files.

The input files for this program include:

Yeast rerep-seq data from GEO GSE168566

WT.bedgraph - This bedgraph contains the Rerep-seq coverage data for WT yeast 
Cu.bedgraph - This bedgraph contains the Rrerep-seq coverage data for copper treated yeast

The output from the code will produce a genomic track image.