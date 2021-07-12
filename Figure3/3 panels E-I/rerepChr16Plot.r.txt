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
parentalChIP <- rtracklayer::import.bw("NDmergeK27redo.bw")
cadR10ChIP <- rtracklayer::import.bw("10DmergeK27redo.bw")

#load chromosome and gene info files  
chromSize <- read_tsv("hg38_dm3_combine.chrom.sizes.txt", col_names=FALSE)
refeqGTF <- "hg38.refGene.gtf"

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
parentalChIPTrack <- DataTrack(parentalChIP, 
				genome="hg38", 
				type="hist" ,
				chromosome ="chr16", 
				name = " ", 
				bakcground.title="white", 
				col.title="black", col.axis="black", 
				col.histogram="black", 
				col.grid = "black", 
				fill="black", 
				ylim = c(0,10))

cadR10ChIPTrack <- DataTrack(cadR10ChIP, 
				genome="hg38", 
				type="hist" ,
				chromosome ="chr16", 
				name = " ", 
				bakcground.title="white", 
				col.title="black", 
				col.axis="black", 
				col.histogram="blue", 
				col.grid = "black", 
				fill="blue", 
				ylim = c(0,10))


#make figure of data tracks and save tiff file   
tiff(filename="3A.tiff",width = 644, height = 150, units = "px", compression = "none", res = 118.11)
plotTracks(c(parentalChIPTrack, cadR10ChIPTrack, gtrack, customRefSeqTxDb2), from=56450000, to=56760000,chromosome="chr16", type="histogram", labelPos="below", background.title="white")
dev.off()

