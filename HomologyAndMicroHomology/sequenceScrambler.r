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




#Provide the path to the insertion file with the FASTA
dfIn <- readr::read_tsv("/path/to/Insertion.BedSequence", col_names = FALSE)
dfIn$scram <- stri_rand_shuffle(dfIn$X5)
dfIn$X4 <- as.character(dfIn$X4)

#Provide the path to the location parent directory containing the origin directories
blastDirsList <- list.dirs(path="/path/to/origins/", full.names = TRUE, recursive = TRUE)
BlastDirsDF <- as.data.frame(blastDirsList)
BlastDirsDf <- tail(BlastDirsDF, -1)

#Extract the base name of the origin files to match up with the corresponding insertion.
BlastDirsDf$fileName <- gsub("/path/to/origins/", "", BlastDirsDf$blastDirsList)
BlastDirsDf$fullName <- paste0(BlastDirsDf$blastDirsList, "/", BlastDirsDf$fileName, ".fa")
foo <- data.frame(do.call('rbind', strsplit(as.character(BlastDirsDf$fileName),'::',fixed=TRUE)))
BlastDirsDfFinal <- cbind(BlastDirsDf, foo)
BlastDirsDfFinal$X1 <- as.character(BlastDirsDfFinal$X1)

dfComplete <- dplyr::inner_join(dfIn, BlastDirsDfFinal, by=c("X4"="X1"))

#For each origin origin and insertion pair, scramble the insertion and save both the origin and the
#insertion fasta files in the same directory.
for(i in 1:nrow(dfComplete)){
  
  dfW <- dfComplete[i,]
  dir <- as.character(dfW$blastDirsList)
  sequence <- as.character(dfW$X5)
  scram <- as.character(dfW$scram)
  name <- as.character(dfW$X4)
  
  write.fasta(sequence, paste0(name, ".seq.fasta"), paste0(dir, "/", name, ".seq.fasta"), open="w")
  write.fasta(scram, paste0(name, ".scram.fasta"), paste0(dir, "/", name, ".scram.fasta"), open="w")
  
  rm(dfW, dir, sequebce, scram, name)
}

  


