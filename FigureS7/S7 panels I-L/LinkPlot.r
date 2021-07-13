library(readr)
library(dplyr)
library(rtracklayer)
library(trackViewer)
library(GenomicInteractions)
library(Gviz)
library(GenomicFeatures)
library(GenomicTools)



# This script will generate a genomic link plot for a specific region of the genome. By changing the reference files,
# diferent species and regions can be displayed. This code was used to generate the figures seen in supplemental figure
# 7, panels I-L.


#define the regon of interest
locus <- list(chr = 'chr16', start = 56550000, end = 56680000)
  
#create a reference idiogram and genomic axis to orient the viewer to the location being displayed.
ideogram.track <- IdeogramTrack(genome = 'hg38', chromosome = locus$chr)
genome.axis.track <- GenomeAxisTrack(fontcolor = "black", col="black")

#Set the working directory
setwd("/path/to/files")

#genomic interactions require left and right aspectes of an interaction. Load these files here.
#These should be bed files, where each row is a unique interaction.

left <- read_tsv("left.bed", col_names = FALSE)
right <- read_tsv("right.bed", col_names = FALSE)

#process these for duplicates
leftNoDups <- left[!duplicated(left$X8), ]
rightNoDups <- right[!duplicated(right$X8), ]

leftFinal <- dplyr::select(leftNoDups, X8, X4)
rightFinal <- dplyr::select(rightNoDups, X8, X4)


dataFinal <- dplyr::full_join(leftFinal, rightFinal, by = c("X8"="X8"))
dataEdges <- dplyr::select(dataFinal, X4.x, X4.y)


frequencies <-data.frame(ftable(dataEdges))
freqOut <- dplyr::filter(frequencies, Freq>0)
freqOut$X4.x <- as.numeric(as.character(freqOut$X4.x))
freqOut$X4.y <- as.numeric(as.character(freqOut$X4.y))

#Load a key to make sure the left and right sides of each interaction are correctly paired.
linkKey <- read_tsv("key.bed", col_names = FALSE)

freqCombine <- full_join(freqOut, linkKey, by = c("X4.x"="X4"))
freqFinal <- full_join(freqCombine, linkKey, by = c("X4.y"="X4"))


freqFinal <- dplyr::filter(freqFinal, Freq>0)


freqFinal$bait.id <- paste0(freqFinal$X1.x, ":", freqFinal$X2.x, "-", (freqFinal$X2.x+10))
freqFinal$target.id <- paste0(freqFinal$X1.y, ":", freqFinal$X2.y, "-", (freqFinal$X2.y+10))

freqFinal$diff <- abs(freqFinal$X4.y - freqFinal$X4.x)


metalloSpan <- dplyr::filter(freqFinal, X2.x<56520000)
metalloSpan <- dplyr::filter(metalloSpan, X2.y>56720000)


#Create the interaction objects using the genomicInteractions package
interaction.objectMetalloSpan <- GenomicInteractions(
  anchor1 = GRanges( metalloSpan$bait.id ),
  anchor2 = GRanges( metalloSpan$target.id ), 
  counts = metalloSpan$Freq
)

interaction.trackMetalloSpan<- InteractionTrack(
  interaction.objectMetalloSpan,
  name = 'MetalloSpan',
)


WithinMetallo <- dplyr::filter(freqFinal, X2.x>56520000)
WithinMetallo <- dplyr::filter(WithinMetallo, X2.y<56720000)

interaction.objectWithinMetallo <- GenomicInteractions(
  anchor1 = GRanges( WithinMetallo$bait.id ),
  anchor2 = GRanges( WithinMetallo$target.id ), 
  counts = WithinMetallo$Freq
)

interaction.trackWithinMetallo<- InteractionTrack(
  interaction.objectWithinMetallo,
  name = 'InMetallo',
)




MetalloOri <- dplyr::filter(freqFinal, X2.x>56520000 & X2.x<56720000)
MetalloOriF <- dplyr::filter(MetalloOri, X2.y>56720000 | X2.y <56520000)

MetalloIns <- dplyr::filter(freqFinal, X2.y>56520000 & X2.y<56720000)
MetalloInsF <- dplyr::filter(MetalloIns, X2.x>56720000 | X2.x <56520000)


metalloOut <- rbind(MetalloOriF, MetalloInsF)


interaction.objectMetalloOut <- GenomicInteractions(
  anchor1 = GRanges( metalloOut$bait.id ),
  anchor2 = GRanges( metalloOut$target.id ), 
  counts = metalloOut$Freq
)

interaction.trackMetalloOrigin<- InteractionTrack(
  interaction.objectMetalloOut,
  name = 'MetalloChr16',
)


#Load annotation files to provide reference and context to the final visualization.

ERD <- rtracklayer::import.bed("ERD.bed")
LRD <- rtracklayer::import.bed("LRD.bed")
Rep <- rtracklayer::import.bed("RepOris_MCF7_Breast Cancer_Ext87521155_hg38.bed")

#Turn these reference files into gviz objects to be plotted.
bedERD <- AnnotationTrack(ERD, genome = "hg38", 
                          chromosome = "chr16",
                          # name = "ERD",
                          col = "blue",
                          fill = "blue",
                          collapse = TRUE, 
                          background.panel="white", 
                          background.title="white", 
                          stacking="dense", 
                          min.height=0.1)

bedLRD <- AnnotationTrack(LRD, genome = "hg38", 
                          chromosome = "chr16",
                          # name = "LRD",
                          col = "red",
                          fill = "red",
                          collapse = TRUE, 
                          background.panel="white", 
                          background.title="white", 
                          stacking="dense", 
                          min.height=0.1)

repTrack <- DataTrack(Rep, genome = "hg38", 
                      chromosome = "chr16",
                      # name = "LRD",
                      col = "purple",
                      fill = "purple",
                      collapse = TRUE, 
                      background.panel="white", 
                      background.title="white", 
                      # stacking="dense", 
                      min.height=0.1)


WithinMetallo <- dplyr::filter(freqFinal, X2.x>56520000)
WithinMetallo <- dplyr::filter(WithinMetallo, X2.y<56720000)
WithinMetallo <- dplyr::filter(WithinMetallo, Freq>2)

interaction.objectWithinMetallo <- GenomicInteractions(
  anchor1 = GRanges( WithinMetallo$bait.id ),
  anchor2 = GRanges( WithinMetallo$target.id ), 
  counts = WithinMetallo$Freq
)

interaction.trackWithinMetallo<- InteractionTrack(
  interaction.objectWithinMetallo,
  name = 'InMetallo',
)

#Define the final display parameters.
displayPars(interaction.trackWithinMetallo) = list(col.interactions="black", 
                                                   col.anchors.fill ="black",
                                                   col.anchors.line = "black",
                                                   interaction.dimension="height", 
                                                   interaction.measure ="counts",
                                                   plot.trans=FALSE,
                                                   plot.outside = TRUE, 
                                                   col.outside="lightblue", 
                                                   anchor.height = 0.03, 
                                                   background.title="white",
                                                   col.frame="white", 
                                                   col.axis="black",
                                                   col="black", 
                                                   col.title="black")



#Load gencode reference genes.
gencodeHg38.v35 <- makeTxDbFromGFF("gencode.v35.basic.annotation.gff3")


getOption("Gviz.scheme")
scheme <- getScheme()
scheme$GeneRegionTrack$fill <- "black"
scheme$GeneRegionTrack$col <- "black"
addScheme(scheme, "myScheme")
options(Gviz.scheme = "myScheme")

gene.track <- GeneRegionTrack(
  gencodeHg38.v35,
  chr = locus$chr,
  start = locus$start,
  end = locus$end,
  stacking = 'squish',
  stackHeight = 0.3, 
  background.title="white",
  col.frame="white", 
  col.axis="black",
  col="black", 
  col.title="black"
  
)

#PLot the final tracks.
plotTracks(list(interaction.trackWithinMetallo, genome.axis.track, gene.track, repTrack, bedERD), sizes = c(1, 0.5, 0.5, 0.1, 0.1), chromosome ="chr16", from = locus$start, to = locus$end)
