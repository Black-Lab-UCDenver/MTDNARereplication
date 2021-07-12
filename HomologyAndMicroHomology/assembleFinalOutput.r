library(readr)
library(dplyr)

#Provide the path to the parent diectory for the origins.
setwd("/path/to/origins")


dirsList <- list.dirs(path=".", full.names = TRUE, recursive = TRUE)
dirsList<-tail(dirsList, -1)

for(n in dirsList){
  print(n)
  dfSeq <- read_csv(paste0(n,"/out.seq.csv"), col_names = TRUE)
  dfScram <- read_csv(paste0(n,"/out.scram.csv"), col_names = TRUE)
  dfRandG <- read_csv(paste0(n,"/out.RandG.csv"), col_names = TRUE)
  
  seqKeep <- dplyr::select(dfSeq, qstart, qend, sstart, send, evalue)
  scramKeep <- dplyr::select(dfScram, qstart, qend, sstart, send, evalue)
  randGKeep <- dplyr::select(dfRandG, qstart, qend, sstart, send, evalue)
  
  seqMin <- min(seqKeep$evalue)
  scramMin <- min(scramKeep$evalue)
  randGMin <- min(randGKeep$evalue)
  
  seqKeepMin <- dplyr::filter(seqKeep, evalue==seqMin)
  seqKeepMinF <- head(seqKeepMin, 1)
  scramKeepMin <- dplyr::filter(scramKeep, evalue==scramMin)
  scramKeepMinF <- head(scramKeepMin, 1)
  randGKeepMin <- dplyr::filter(randGKeep, evalue==randGMin)
  randGKeepMinF <- head(randGKeepMin, 1)
  
  colnames(seqKeepMinF) <- c("SeqQstart", "SeqQend", "SeqSstart", "SeqSend", "SeqEvalue")
  colnames(scramKeepMinF) <- c("ScramQstart", "ScramQend", "ScramSstart", "ScramSend", "ScramEvalue")
  colnames(randGKeepMinF) <- c("RandGQstart", "RandGQend", "RandGSstart", "RandGSend", "RandGEvalue")
  
  out <- cbind(seqKeepMinF, scramKeepMinF, randGKeepMinF)
  
  if(exists("outFinal")==FALSE){
    outFinal <- out
  }else{
    outFinal <- rbind(outFinal, out)
  }
  
  rm(dfSeq, dfScram, dfRandG, seqKeep, scramKeep, randGKeep, seqMin, scramMin, randGMin, seqKeepMin, seqKeepMinF, scramKeepMin, scramKeepMinF, randGKeepMin, randGKeepMinF, out)
}


outFinal$SeqEvalue <- as.numeric(outFinal$SeqEvalue)
outFinal$ScramEvalue <- as.numeric(outFinal$ScramEvalue)
outFinal$RandGEvalue <- as.numeric(outFinal$RandGEvalue)


outFinal$SeqNegLogEval <- log10(1/outFinal$SeqEvalue)
outFinal$ScramNegLogEval <- log10(1/outFinal$ScramEvalue)
outFinal$RandGNegLogEval <- log10(1/outFinal$RandGEvalue)

write_tsv(outFinal, "homology.tsv", col_names = TRUE)


