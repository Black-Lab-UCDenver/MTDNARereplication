The code featured in this directory corresponds to figure 3, panels E-I. Files necessary to create this figure can be obtained from the locations listed below. R code to generage these figures is the same as Figure 2 panel G (https://github.com/Black-Lab-UCDenver/MTDNARereplication/blob/master/Figure2%20panel%20G/genomicTrack.r). Please note that Gviz can be difficult to install, and requires R version 3.6. Make sure you have Rcurl working and updated on your machine prior to instillation of Gviz. If you do choose to run the R program in this directory, please change the working directory in the code to the location of the input files.


The input files for this program include:

For Figure 3 panel E:

Human ChIP-seq data from GEO GSE

NDmergeK27redo.bw - This bigwig contains the H3K27me3 ChIP-seq coverage data for parental cells
10DmergeK27redo.bw - This bigwig contains the H3K27me3 ChIP-seq coverage data for cadmium treated cells 
hg38.refGene.gtf - This file contains reference gene information from UCSC table browser (http://genome.ucsc.edu/cgi-bin/hgTables)

For Figure 3 panels F-I

Human ChIP-seq data from GEO GSE
Human CUT&RUN data from GEO GSE
Human rerep-seq data from GEO GSE165865

NDmergeK27redo.bw - This bigwig contains the H3K27me3 ChIP-seq coverage data for parental cells
10DmergeK27redo.bw - This bigwig contains the H3K27me3 ChIP-seq coverage data for cadmium treated cells 
ReplicationOrigins.bedgraph - Predicted origin data from MCF7 cells (Hansen et al., 2010) lifted over from hg19 to hg38 using UCSC liftover (https://genome.ucsc.edu/cgi-bin/hgLiftOver)
parentalEZH2.bw - This bigwig contains the EZH2 CUT&RUN coverage data for parental cells
cadREZH2.bw - This bigwig contains the EZH2 CUT&RUN coverage data for cadmium treated cells 
parentalSUZ12.bw - This bigwig contains the SUZ12 CUT&RUN coverage data for parental cells
cadRSUZ12.bw - This bigwig contains the SUZ12 CUT&RUN coverage data for cadmium treated cells 
parental.rpmMito.50bpBin.10kbsmooth.bedgraph - This bedgraph contains the Rerep-seq coverage data for parental cells 
cad75.rpmMito.50bpBin.10kbsmooth.bedgraph - This bedgraph contains the Rrerep-seq coverage data for cadmium treated cells 
parental.rpmMito.50bpBin.10kbsmooth.bedgraph - This bedgraph contains the Rerep-seq coverage data for parental cells 
cad75.rpmMito.50bpBin.10kbsmooth.bedgraph - This bedgraph contains the Rrerep-seq coverage data for cadmium treated cells 
hg38.refGene.gtf - This file contains reference gene information from UCSC table browser (http://genome.ucsc.edu/cgi-bin/hgTables)

The output from the code will produce a genomic track image.

![alt text](https://github.com/Black-Lab-UCDenver/MTDNARereplication/blob/master/images/Figure3.png?raw=true)

# for figure 3 panel E use the following location data:
chromosome="chr16"
from=56450000
to=56760000

# for figure 3 panel F use the following location data:
chromosome="chr16"
from=56613430
to=56621923

# for figure 3 panel G use the following location data:
chromosome="chr16"
from=56631000 
to=56638000 

# for figure 3 panel H use the following location data:
chromosome="chr16"
from=56657000
to=56665000

# for figure 3 panel I use the following location data:
chromosome="chr16"
from=56680665
to=56691744