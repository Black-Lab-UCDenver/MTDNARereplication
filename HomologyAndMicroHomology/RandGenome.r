library(readr)
library(dplyr)
library(StructuralVariantAnnotation)
library(rtracklayer)
library(circlize)
library(reshape2)
library(tidyverse)
library(stringi)
library(hoardeR)
library(zoo)
library(rBLAST)
library(seqinr)


#Provide the paths to the origins and the random sequence parent directories.
blastDirsList <- list.dirs(path="/path/to/origins", full.names = TRUE, recursive = TRUE)
  randGenome1K <- list.files(path="/path/to/randGenome/fastaFiles", full.names = TRUE, recursive = TRUE)

  #Randomly assign a randome genomic region to an origin and save the randome genomic region to the same origin directory.
dirNum <- length(blastDirsList)
randOrder <- round(runif(dirNum, 1, 10000))

dfDirs <- as.data.frame(blastDirsList)
dfDirs$dirOrder <- rownames(dfDirs)
dfRandGen <- as.data.frame(randGenome1K)
dfRandGen$randSequencePosition <- as.numeric(row.names(dfRandGen))
dfRandOrder <- as.data.frame(randOrder)
dfRandOrder$dirPosition <- row.names(dfRandOrder)

dirsMergedRandOrder <- dplyr::full_join(dfDirs, dfRandOrder, by=c("dirOrder"="dirPosition"))
finalMerged <- dplyr::inner_join(dirsMergedRandOrder, dfRandGen, by=c("randOrder"="randSequencePosition"))


for(i in 1:nrow(finalMerged)){
  
  dfW <- finalMerged[i,]
  fastaLocation <- as.character(dfW$randGenome1K)
  faIn <- as.character(read.fasta(fastaLocation, seqonly=TRUE, as.string = TRUE))
  name <- gsub(".fa", "", fastaLocation)
  name <- gsub("/path/to/randGenomic/fastaFiles/", "", name)
  dirLoc <- as.character(dfW$blastDirsList)
  
  write.fasta(faIn, paste0(name, ".RandGenome.fasta"), paste0(dirLoc, "/", name, ".RandGenome.fasta"), open="w")
  rm(dfW, fastaLocation, faIn, name, dirLoc)
}
