The code featured in this directory corresponds to figure 3, panel H. All the necessary files to generate this figure panel are provided here. Please note that Gviz can be difficult to install, and requires R version 3.6. Make sure you have Rcurl working and updated on your machine prior to instillation of Gviz. If you do choose to run the R program in this directory, please change the working directory in the code to the location of the input files.

The input files for this program include:

NDmergeK27redo.bw
	This bigwig contains the H3K27me3 ChIP-seq coverage data for parental cells
10DmergeK27redo.bw
	This bigwig contains the H3K27me3 ChIP-seq coverage data for cadmium treated cells
RepOris_MCF7_Breast Cancer_Ext87521155_hg38.bedgraph
	This bedgraph contains expected origin data in MCF7 cells. This file is from (Hansen et al., 2010) and was lifted over from hg19 to hg38 using UCSC liftover (https://genome.ucsc.edu/cgi-bin/hgLiftOver)
Parental18MergedAveraged.bedgraph
	This bedgraph contains the Rerep-seq coverage data for parental cells
Cad18MergedAveraged.bedgraph
	This bedgraph contains the Rrerep-seq coverage data for cadmium treated cells	
parental.rpmMito.50bpBin.bedgraph
	This bedgraph contains the Rerep-seq coverage data for parental cells
cad75.rpmMito.50bpBin.bedgraph
	This bedgraph contains the Rrerep-seq coverage data for cadmium treated cells	
No_EZH2_merge_trimmed_150.bw
	This bigwig contains the EZH2 CUT&RUN coverage data for parental cells
10_EZH2_merge_trimmed_150.bw
	This bigwig contains the EZH2 CUT&RUN coverage data for cadmium treated cells
No_SUZ12_merge_trimmed_150.bw
	This bigwig contains the SUZ12 CUT&RUN coverage data for parental cells
10_SUZ12_merge_trimmed_150.bw
	This bigwig contains the SUZ12 CUT&RUN coverage data for cadmium treated cells
hg38_dm3_combine.chrom.sizes
	This file contains a list of chromosomes and their nucleotide sizes
hg38.refGene.gtf
	This file contains reference gene information

The output from the code will produce a genomic track image.