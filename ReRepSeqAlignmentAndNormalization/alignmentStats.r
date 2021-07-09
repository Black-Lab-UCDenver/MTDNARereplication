#Generate alignment stats
#Alter the file paths to the correct directory 

library(readr)
library(dplyr)

setwd("/path/to/parent/directory/of/alignments/")

dirsList <- list.dirs(path=".", full.names=TRUE, recursive = TRUE)

for(dir in dirsList){
  setwd("/path/to/parent/directory/of/alignments/")
  print(dir)
  setwd(paste(dir))
  
  tryCatch({
    statsIn <- read_tsv("stats.chrom.txt", col_names = FALSE)
    aligned <- sum(statsIn$X3)
    unaligned <- sum(statsIn$X4)
    # chrM <- statsIn[X3, "chrM"]
    
    blStats <- read_tsv("blackListStats.txt", col_names = FALSE)
    totalBlackListed <- sum(blStats$X3)
    
    
    out <- data.frame(dir, aligned, unaligned, totalBlackListed)
    
    if(exists("outFinal")==FALSE){
      outFinal <- out
    }else{
      outFinal <- rbind(outFinal, out)
    }
    
    rm(statsIn, aligned, unaligned, totalBlackListed, out)
  }, error=function(e){})
}
  

  
write_csv(outFinal, "/path/to/directory/to/save/alignmentStats.csv", col_names = TRUE)
