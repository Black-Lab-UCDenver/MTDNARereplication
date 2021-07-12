library(readr)
library(dplyr)

#Provide the path to the parent directory containing origins
setwd("/path/to/origins")
inSeqList <- list.files(pattern="*.csv", full.names = TRUE, recursive = TRUE)


for(i in inSeqList){
  if(file.size(paste(i))==0){
    print("no info")
    print(i)
    dfIn <- data.frame("NA", "NA", "NA", "NA", "NA", "NA", "NA", "NA", "1", "NA", "NA", "NA", "NA", "NA", "NA", "NA", "NA", "NA", "NA")
    colnames(dfIn) <- c("qseqid", "sseqid", "qstart", "qend", "sstart", "send", "qseq", "sseq", "evalue", "bitscore", "score", "length", "pident", "nident", "mismatch", "positive", "gapopen", "gaps", "ppos")
    write_csv(dfIn, i, col_names = TRUE)
    rm(dfIn)
  }else{ 
    print("info")
    print(i)
    dfIn <- read_csv(i, col_names = FALSE)
    colnames(dfIn) <- c("qseqid", "sseqid", "qstart", "qend", "sstart", "send", "qseq", "sseq", "evalue", "bitscore", "score", "length", "pident", "nident", "mismatch", "positive", "gapopen", "gaps", "ppos")
    write_csv(dfIn, i, col_names = TRUE)
    rm(dfIn)
  }
  
  # rm(dfIn)
}


for(i in inSeqList){
  if(file.size(paste(i))==0){
    print("no info")
    print(i)
    # dfIn <- data.frame("NA", "NA", "NA", "NA", "NA", "NA", "NA", "NA", "1", "NA", "NA", "NA", "NA", "NA", "NA", "NA", "NA", "NA", "NA")
    # colnames(dfIn) <- c("qseqid", "sseqid", "qstart", "qend", "sstart", "send", "qseq", "sseq", "evalue", "bitscore", "score", "length", "pident", "nident", "mismatch", "positive", "gapopen", "gaps", "ppos")
    # write_csv(dfIn, i, col_names = TRUE)
    # rm(dfIn)
  }else{ 
    # print("info")
    # print(i)
  }
  
  # rm(dfIn)
}











