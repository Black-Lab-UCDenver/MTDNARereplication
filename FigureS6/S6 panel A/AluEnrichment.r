library(readr)
library(dplyr)


dfGen <- read_tsv("/home/blacklab/Documents/repbase/RepeatMaskerDfamHg38", col_names = FALSE)
dfHum <- read_tsv("/home/blacklab/Desktop/humanCadInput/randomGenomeRepeats.bed", col_names = FALSE)  

uniqueRep <- split(dfHum, dfHum$X4)

for(n in uniqueRep){
  print(n)
  humW <- n
  genW <- dplyr::filter(dfGen, X4==paste(humW[1, "X4"]))
  
  
  dat <- rbind(c(as.numeric(paste(length(dfGen$X4)-length(genW$X4))), as.numeric(paste(length(dfHum$X4)-length(humW$X4)))), c(as.numeric(paste(length(genW$X4))), as.numeric(paste(length(humW$X4)))))
  # dat <- data.matrix(dat)
  test <- fisher.test(dat, alternative = "two.sided")
  
  
  rep <- paste(humW[1, "X4"])
  p.val <- test$p.value
  oddsRatio <- test$estimate
  genPercent <- (length(genW$X4)/length(dfGen$X4))*100
  samplePercent <- (length(humW$X4)/length(dfHum$X4))*100
  
  out <- data.frame(rep, p.val, oddsRatio, genPercent, samplePercent)
  
  if(exists("outFinal")==FALSE){
    outFinal <- out
  }else{
    outFinal <- rbind(outFinal, out)
  }
  
  
  
}

write_csv(outFinal, "/home/blacklab/Documents/repbase/randRepeatEnrichmentDFAM.3.2.csv", col_names = TRUE)
