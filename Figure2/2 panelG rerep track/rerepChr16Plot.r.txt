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
cadR75rerep50binSmooth <- rtracklayer::import.bedGraph("/cad75.rpmMito.50bpBin.10kbsmooth.bedgraph")
parental75rerep50binSmooth <- rtracklayer::import.bedGraph("/parental.rpmMito.50bpBin.10kbsmooth.bedgraph")

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
parental75rerep50binSmoothTrack <- DataTrack(parental75rerep50binSmooth, 
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

cadR75rerep50binSmoothTrack <- DataTrack(cadR75rerep50binSmooth, 
					genome="hg38", 
					type="hist" ,
					chromosome ="chr16", 
					name = " ", 
					bakcground.title="white", 
					col.title="black", 
					col.axis="black", 
					col.histogram="red", 
					col.grid = "black", 
					fill="red", 
					ylim = c(0,50))

#make figure of data tracks and save tiff file   
tiff(filename="2G-rerep-10uM.tiff",width = 680, height = 330, units = "px", compression = "none", res = 118.11)
plotTracks(c(parental10rerepSmoothTrack, cadR10rerepSmoothTrack, gtrack, customRefSeqTxDb2), from=46400000, to=90300000, chromosome="chr16", type="histogram", labelPos="below", background.title="white")
dev.off()
