The code featured in this directory corresponds to figure S7, panel C. All the necessary files to generate this figure panel are provided here. Please note that Gviz can be difficult to install, and requires R version 3.6. Make sure you have Rcurl working and updated on your machine prior to instillation of Gviz. If you do choose to run the R program in this directory, please change the working directory in the code to the location of the input files.

The input files for this program include:

mergedYeastWT.rpmMito.50bpBin.bedgraph
	This bedgraph contains the Rerep-seq coverage data for parental yeast
mergedYeastCU.rpmMito.50bpBin.bedgraph
	This bedgraph contains the Rrerep-seq coverage data for copper treated yeast

The output from the code will produce a genomic track image.