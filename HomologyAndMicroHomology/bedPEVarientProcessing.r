library(readr)
library(dplyr)
library(devtools)
library(hoardeR)
library(rBLAST)
library(Biostrings)


#set the workig directory and specify the path to the file of interest
  setwd("/path/to/bedpeFiles/")
  inFile <- "./bedPEInFile"
  dfIn <- read_tsv(inFile, col_names = FALSE) 
  
#Get the base name of the file. This is used for naming the final files when saving the output.  
  name <- gsub(".gridss_breakpoints.bedpe", "", inFile)
  name <- gsub("./", "", name)

#Get the insertions or origins that start on chrVIII. For human genomes, these files need to be changed accordingly.     
  dfOri8 <- dplyr::filter(dfIn, X2=="chrVIII")
  dfIn8 <- dplyr::filter(dfIn, X5=="chrVIII")
  
  df8 <- rbind(dfOri8, dfIn8)
  
  dfIn.2 <- dplyr::select(df8, X2, X3, X4, X5, X6, X7, X8, X9)
  df2 <- dplyr::select(df8, X5, X6, X7, X2, X3, X4, X8, X9)
  
  non8.1 <-dplyr::filter(dfIn.2, X2!="chrVIII")
  non8.2 <-dplyr::filter(df2, X5!="chrVIII")
  
  colnames(non8.2)<- c("X2", "X3", "X4", "X5", "X6", "X7", "X8", "X9")
  non8 <- rbind(non8.1, non8.2)
  

  for(i in 1:nrow(non8)){
    working <- non8[i,]
    
    if(working$X2!="chrVIII"){
      print("yes")
      out <- dplyr::select(working, X5, X6, X7, X2, X3, X4, X8, X9)
      colnames(out) <- c("X2", "X3", "X4", "X5", "X6", "X7", "X8", "X9")
    }else{
      print("no")
      out <- working
    }
    
    if(exists('outFinal')==FALSE){
      outFinal <- out
    }else{
      outFinal <- rbind(outFinal, out)
    }
    
    rm(out, working)
  }
  
  
#For the origins, filter them to select or CUP1 locus., and remove any variants that link to chrM or spike in control.
  
  outFiltered <- dplyr::filter(outFinal, X3>210500 & X3<218000)
  outFiltered <- dplyr::filter(outFiltered, X5!="pBR322")
  outFiltered <- dplyr::filter(outFiltered, X5!="chrM")

#If desired, the final varients can be filtered by GRIGSS score as follows.    
  yF150 <- dplyr::filter(outFiltered, X9>=150)
  yF200 <- dplyr::filter(outFiltered, X9>=200)
  yF300 <- dplyr::filter(outFiltered, X9>=300)
  yF500 <- dplyr::filter(outFiltered, X9>=500)
  
  outFinal <- yF200
  
#To generate a 1kb region add 500bp to either end of the break point. For micro homology. This should be chnaged to 25bp to generate a 50bp region.  
  outFinal$startOri <- outFinal$X3-500
  outFinal$stopOri <- outFinal$X3+500
  outFinal$startIns <- outFinal$X6-500
  outFinal$stopIns <- outFinal$X6+500
  outFinal$ID <- row.names(outFinal)
  outFinal <- dplyr::filter(outFinal, X5!="pBR322")
  outFinal <- dplyr::filter(outFinal, X5!="chrM")
  
  outOrigin <- dplyr::select(outFinal, X2, startOri, stopOri, X8, X9)
  outOrigin<- dplyr::filter(outOrigin, startOri>=1)
  outInsertion <- dplyr::select(outFinal, X5, startIns, stopIns, X8, X9)
  outInsertion<- dplyr::filter(outInsertion, startIns>=1)
  
  
  write_tsv(outOrigin, "/path/to/nOrigin.bed", col_names=FALSE)
  
  write_tsv(outInsertion, "/path/to/Insertion.bed", col_names=FALSE)
      