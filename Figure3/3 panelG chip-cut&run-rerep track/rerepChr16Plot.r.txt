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
Okasaki <- rtracklayer::import.bedGraph("RepOris_MCF7_Breast Cancer_Ext87521155_hg38.bedgraph")
parental10rerep <- rtracklayer::import.bedGraph("Parental18MergedAveraged.bedgraph")
cadR10rerep <- rtracklayer::import.bedGraph("Cad18MergedAveraged.bedgraph")
parental75rerep50bin <- rtracklayer::import.bedGraph("parental.rpmMito.50bpBin.bedgraph")
cadR75rerep50bin <- rtracklayer::import.bedGraph("cad75.rpmMito.50bpBin.bedgraph")
parentalEZH2 <- rtracklayer::import.bw("No_EZH2_merge_trimmed_150.bw")
cadR10EZH2 <- rtracklayer::import.bw("10_EZH2_merge_trimmed_150.bw")
parentalSUZ12 <- rtracklayer::import.bw("No_SUZ12_merge_trimmed_150.bw")
cadR10SUZ12 <- rtracklayer::import.bw("10_SUZ12_merge_trimmed_150.bw")

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

OkasakiTrack <- DataTrack(Okasaki, 
			genome="hg38", 
			type="hist" ,
			chromosome ="chr16", 
			name = " ", 
			bakcground.title="white", 
			col.title="black", 
			col.axis="black", 
			col.histogram="purple", 
			col.grid = "black", 
			fill="purple", 
			ylim = c(0,5))

parentalEZH2zoom2Track <- DataTrack(parentalEZH2, 
				genome="hg38", type="hist" ,
				chromosome ="chr16", name = " ", 
				bakcground.title="white", 
				col.title="black", 
				col.axis="black", 
				col.histogram="black", 
				col.grid = "black", 
				fill="black", 
				ylim = c(0,2))

cadR10EZH2zoom2Track <- DataTrack(cadR10EZH2, 
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
				ylim = c(0,2))

parentalSUZ12zoom2Track <- DataTrack(parentalSUZ12, 
				genome="hg38", 
				type="hist" ,
				chromosome ="chr16", 
				name = " ", 
				bakcground.title="white", 
				col.title="black", 
				col.axis="black", 
				col.histogram="black", 
				col.grid = "black", 
				fill="black", 
				ylim = c(0,2))

cadR10SUZ12zoom2Track <- DataTrack(cadR10SUZ12, 
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
				ylim = c(0,2))

parental10rerepTrack <- DataTrack(parental10rerep, 
			genome="hg38", type="hist" ,
			chromosome ="chr16", 
			name = " ", 
			bakcground.title="white", 
			col.title="black", 
			col.axis="black", 
			col.histogram="black", 
			col.grid = "black", 
			fill="black", ylim = c(0,100))

cadR10rerepTrack <- DataTrack(cadR10rerep, 
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
			ylim = c(0,100))

parental75rerep50binTrack <- DataTrack(parental75rerep50bin, 
				genome="hg38", 
				type="hist" ,
				chromosome ="chr16", 
				name = " ", 
				bakcground.title="white",
				col.title="black", 
				col.axis="black", 
				col.histogram="black", 
				col.grid = "black", 
				fill="black", 
				ylim = c(0,100))

cadR75rerep50binTrack <- DataTrack(cadR75rerep50bin, 
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
				ylim = c(0,100))

#make figure of data tracks and save tiff file   
tiff(filename="3G.tiff",width = 280, height = 572, units = "px", compression = "none", res = 118.11)
plotTracks(c(parentalChIPTrack, cadR10ChIPTrack, OkasakiTrack, parentalEZH2zoom2Track, cadR10EZH2zoom2Track, parentalSUZ12zoom2Track, cadR10SUZ12zoom2Track, parental10rerepTrack, cadR10rerepTrack, parental75rerep50binTrack, cadR75rerep50binTrack, gtrack, customRefSeqTxDb2), from=56631000, to=56638000 ,chromosome="chr16", type="histogram", labelPos="below", background.title="white", ticksAt=c(56633000, 56637000))
dev.off()


