The code featured in this directory corresponds to figure S2, panel F. All the necessary files to generate this figure panel are provided here. Please note that Gviz can be difficult to install, and requires R version 3.6. Make sure you have Rcurl working and updated on your machine prior to instillation of Gviz. If you do choose to run the R program in this directory, please change the working directory in the code to the location of the input files.

The input files for this program include:

Parental18MergedAveraged.50bp.10kbsmooth.bedgraph
	This bedgraph contains the Rerep-seq coverage data for parental cells
Cad18MergedAveraged.50bp.10kbsmooth.bedgraph
	This bedgraph contains the Rrerep-seq coverage data for cadmium treated cells
hg38_dm3_combine.chrom.sizes
	This file contains a list of chromosomes and their nucleotide sizes
hg38.refGene.gtf
	This file contains reference gene information

The output from the code will produce a genomic track image.