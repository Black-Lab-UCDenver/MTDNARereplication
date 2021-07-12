library(readr)
library(dplyr)
library(hoardeR)
library(zoo)

#Provide the path to the chromosome size file and select the chromosomes for ramdom region selection.
dfIn <- read_tsv("/path/to/.chrom.sizes", col_names = FALSE)
dfselect <- filter(dfIn, X1=="chr1"| X1=="chr2" | X1=="chr3" | X1=="chr4" | X1=="chr5" | X1=="chr6" | X1=="chr7" | X1=="chr8" | X1=="chr9" | X1=="chr10" | X1=="chr11" | X1=="chr12" | X1=="chr13" | X1=="chr14" | X1=="chr15" | X1=="chr16" | X1=="chr17" | X1=="chr18" | X1=="chr19" | X1=="chr20" | X1=="chr21" | X1=="chr22" | X1=="chrX")


dfselect$stop <- cumsum(dfselect$X2)
dfselect$start <- (dfselect$stop - dfselect$X2)+1

lengthGenome <- sum(dfselect$X2)
rand <- round(runif(10000, 1, lengthGenome), 0)

#Change the +/- to determine the size of the randomly selected region. For microhomology the +/- should be 25, for notmal homology it should be 500.
for(i in rand){
  print(i)
  chrom <-filter(dfselect, start<=i&stop>=i)
  positionOnChrom <- i-chrom$start
  startPos <- positionOnChrom -5000
  stopPos <- positionOnChrom+5000
  chr <- chrom$X1
    
  if(stopPos>chrom$X2){
    stopPos <- positionOnChrom
    startPos <- positonOnChrom-10000
  }else if(startPos<1){
    startPos <- positionOnChrom
    stopPos <- positionOnChrom+10000
  }else{}
  
  randBed <- data.frame(chr, startPos, stopPos)
  
  if(exists("randBedOut")==FALSE){
    randBedOut <- randBed
  }else{
    randBedOut <- rbind(randBedOut, randBed)
  }
  

}


write_tsv(randBedOut, "/location/to/save/randgenome.bed", col_names = FALSE)


