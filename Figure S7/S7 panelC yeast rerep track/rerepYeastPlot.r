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
yeastWt <- rtracklayer::import.bedGraph("mergedYeastWT.rpmMito.50bpBin.bedgraph")
yeastCu <- rtracklayer::import.bedGraph("mergedYeastCU.rpmMito.50bpBin.bedgraph")
yeastWtboth <- rtracklayer::import.bedGraph("mergedWT.BothCups.rpmMito.50bpBin.bedgraph")
yeastCuboth <- rtracklayer::import.bedGraph("mergedCU.BothCups.rpmMito.50bpBin.bedgraph")

#load chromosome and gene info files  

#create gene model and reference track  
sacCer <- TxDb.Scerevisiae.UCSC.sacCer3.sgdGene
gtrack <- GenomeAxisTrack(fontcolor="black", 
				col="black", 
				labelPos="below")

yeastGenes <- GeneRegionTrack(sacCer, 
			chromosome="chrVIII", 
			name="RefSeq", 
			fontcolor="black")

displayPars(yeastGenes) <- list(fontcolor.group = "blue", 
			fontcolor.item="blue",
			col="blue", 
			fill = "blue", 
			col.line = "blue", 
			transcriptAnnotation = "gene", 
			cex = 1.2, 
			fontcolor.item = NULL, 
			stacking = "dense")

#Create tracks for input files
yeastWtTrack <- DataTrack(yeastWt, 
			genome="SacCer3", 
			type="hist" ,
			chromosome ="chrVIII", 
			name = " ", 
			bakcground.title="white", 
			col.title="black", 
			col.axis="black", 
			col.histogram="black", 
			col.grid = "black", 
			fill="black", 
			ylim = c(0,2500))

yeastCuTrack <- DataTrack(yeastCu, 
			genome="SacCer3", 
			type="hist" ,
			chromosome ="chrVIII", 
			name = " ", 
			bakcground.title="white", 
			col.title="black", 
			col.axis="black", 
			col.histogram="red", 
			col.grid = "black", 
			fill="red", 
			ylim = c(0,2500))

#make figure of data tracks and save tiff file   
tiff(filename="S7C.tiff",width = 315, height = 572, units = "px", compression = "none", res = 118.11)
plotTracks(c(yeastWtTrack, yeastCuTrack, gtrack, yeastGenes), from=210000, to=218000, chromosome = "chrVIII", type="histogram", labelPos="below", background.title="white")
dev.off()

