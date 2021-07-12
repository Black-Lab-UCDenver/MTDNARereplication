#Load libraries
library(readr)
library(dplyr)
library(RCurl)
library(rtracklayer)
library(GenomicFeatures)
library(AnnotationDbi)
library(Gviz)
library(GenomicRanges)
library(grid)

#Change this directory to location of the downloaded inout files.
setwd("/path/to/files")

#Load the input files.
#Files may be obtained from GEO with the following GSE numbers:
#
#Human rerep-seq data:
#Yeast rerep-seq data:
#Human ChIP-seq data:
#Human CUT&RUN data:
#
#Copy and paste input line for bedgraph or bigwig
#Make a seperate line for each input file to be shown in track figure
#
InputBedgraph <- rtracklayer::import.bedGraph("filename.bedgraph")
InputBigWig <- rtracklayer::import.bw("filename.bw")

#load chromosome and gene info files  
#hg38 refGene may be obtained from UCSC table browser
#http://genome.ucsc.edu/cgi-bin/hgTables
#
#Replace "ReferenceGene.gtf" with file obtained from UCSC table browser
#
chromSize <- read_tsv("chrom.sizes.txt", col_names=FALSE)
refeqGTF <- "ReferenceGene.gtf"

#create gene model and reference track  
data(geneModels)
txdbRefseq <- makeTxDbFromGFF(file=refeqGTF)
gtrack <- GenomeAxisTrack(fontcolor="black", 
				col="black", 
				labelPos="below")

options(ucscChromosomeNames = FALSE)
customRefSeqTxDb2 <- GeneRegionTrack(txdbRefseq, 
					chromosome="chr16", 
					name="RefSeq", 
					fontcolor="black")

displayPars(customRefSeqTxDb2) <- list(fontcolor.group = "blue", 
					fontcolor.item="blue",
					col="blue", 
					fill = "blue", 
					col.line = "blue", 
					transcriptAnnotation = "gene", 
					cex = 1.2, 
					fontcolor.item = NULL, 
					stacking = "dense")


#Create tracks for input files
#Copy code below and modify for each Input file loaded
#
#Change chromosome "chr16" if looking at a different chromosome
#Modify colors and ylim data c(0,50) range accordingly
#
track1 <- DataTrack(InputBedgraph, 
			genome="hg38", 
			type="hist" ,
			chromosome ="chr16", 
			name = " ", 
			bakcground.title="white", 
			col.title="black", col.axis="black", 
			col.histogram="black", 
			col.grid = "black", 
			fill="black", 
			ylim = c(0,50))

#make figure of data tracks and save tiff file   
#add tracks to the plotTracks list for each track created
#
# plotTracks(c(track1, track2, track3 ... etc.
#
#change "chr16", from= and to= according to desired window view
#
tiff(filename="2G-rerep-10uM.tiff",width = 680, height = 330, units = "px", compression = "none", res = 118.11)
plotTracks(c(track1, gtrack, customRefSeqTxDb2), from=46400000, to=90300000, chromosome="chr16", type="histogram", labelPos="below", background.title="white")
dev.off()
