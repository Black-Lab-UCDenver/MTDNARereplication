library(readr)
library(dplyr)

#Add the path to the homology output from blastn

dfIn <- read_tsv("/path/to/homology.tsv", col_names = TRUE)

SeqQ <- dplyr::select(dfIn, SeqQstart, SeqQend, SeqNegLogEval)
SeqS <- dplyr::select(dfIn, SeqSstart, SeqSend, SeqNegLogEval)

ScramQ <- dplyr::select(dfIn, ScramQstart, ScramQend, ScramNegLogEval)
ScramS <- dplyr::select(dfIn, ScramSstart, ScramSend, ScramNegLogEval)

RandGQ <- dplyr::select(dfIn, RandGQstart, RandGQend, RandGNegLogEval)
RandGS <- dplyr::select(dfIn, RandGSstart, RandGSend, SeqNegLogEval)


SeqQ$sample <- "seqInsert"
SeqS$sample <- "seqOri"
ScramQ$sample <- "scramInsert"
ScramS$sample <- "scramOri"
RandGQ$sample <- "randGInsert"
RandGS$sample <- "randGOri"

SeqQ$color <- "seq"
SeqS$color <- "seq"
ScramQ$color <- "scram"
ScramS$color <- "scram"
RandGQ$color <- "randG"
RandGS$color <- "randG"

SeqQ$dot <- "Insert"
SeqS$dot <- "Ori"
ScramQ$dot <- "Insert"
ScramS$dot <- "Ori"
RandGQ$dot <- "Insert"
RandGS$dot <- "Ori"

colnames(SeqQ) <- c("start", "stop", "adjEval", "sample", "color", "dot")
colnames(SeqS) <- c("start", "stop", "adjEval", "sample", "color", "dot")
colnames(ScramQ) <- c("start", "stop", "adjEval", "sample", "color", "dot")
colnames(ScramS) <- c("start", "stop", "adjEval", "sample", "color", "dot")
colnames(RandGQ) <- c("start", "stop", "adjEval", "sample", "color", "dot")
colnames(RandGS) <- c("start", "stop", "adjEval", "sample", "color", "dot")

finalOut <- rbind(SeqQ, SeqS, ScramQ, ScramS, RandGQ, RandGS)

for(n in 1:nrow(finalOut)){
  
  dfW1 <- finalOut[n,]
  if(isTRUE(dfW1$stop<dfW1$start)){
    dfOut <- dplyr::select(dfW1, stop, start, adjEval, sample, color, dot)
    colnames(dfOut) <- c("start", "stop", "adjEval", "sample", "color", "dot")
  }else{
    dfOut <- dfW1
  }
  
  rm(dfW1)
  
  if(exists('dfFinalOut')==FALSE){
    dfFinalOut <- dfOut
  }else{
    dfFinalOut <- rbind(dfFinalOut, dfOut)
  }
  
  
  
}





for (i in 1:nrow(dfFinalOut)){
  print(i)
  dfW <- dfFinalOut[i,]
  print(dfW)
  
  if(is.na(dfW$start)=='TRUE'){
    print("na")
    out <- data.frame(t(data.frame(rep(0, 1000))))
    out$sample <- dfW$sample
    out$color <- dfW$color
    out$dot <- dfW$dot
    
    
  }else{
    print("nope")
    first <- rep(0, paste(dfW$start))
    secLength <- dfW$stop - dfW$start
    second <- rep(paste(dfW$adjEval), secLength)
    thirdLength <- 1000-dfW$stop
    third <- rep(0, thirdLength)
    out <- data.frame(t(data.frame(c(first, second, third))))

    
    out$sample <- dfW$sample
    out$color <- dfW$color
    out$dot <- dfW$dot
    
    
    
    rm(first, secLength, second, thirdLength, third)
  }
  
  if(exists('outFinal')==FALSE){
    outFinal <- out
  }else{
    outFinal <- rbind(outFinal, out)
  }
  
  rm(out, dfW)
  
}
  

splitOut <- split(outFinal, outFinal$sample)

for(z in splitOut){
  # print(z)
  dfW2 <- dplyr::select(z, -sample, -color, -dot)
  dfW2 <- data.frame(data.matrix(dfW2))
  dfWchar <- dplyr::select(z, sample, color, dot)
  
  dfW2ColAve <- data.frame(colSums(dfW2)/length(dfW2$X1))
  
  sample <- dfWchar[1, 'sample']
  color <- dfWchar[1, 'color']
  dot <- dfWchar[1, 'dot']
  
  
  dfW2ColAve$position <- as.factor(1:1000)
  dfW2ColAve$sample <- sample
  dfW2ColAve$color <- color
  dfW2ColAve$dot <- dot
  
  colnames(dfW2ColAve)<- c("logEval", "position", "sample", "color", "dot")
  
  if(exists('plotData')==FALSE){
    plotData<- dfW2ColAve
  }else{
    plotData <- rbind(plotData, dfW2ColAve)
  }
  
  rm(dfW2, dfW2ColAve, sample, color, dot, dfWchar)
}

plotData$logEval <- as.numeric(plotData$logEval)



#add the path to the director where you want the final image saved
tiff(filename = "/path/to/Trace.tiff", height = 1200, width = 1200, units="px")

 ggplot(plotData, aes(position, logEval, group = color, colour=color))+
  geom_smooth(method = "loess", se=FALSE, size=4)+
  scale_color_manual(values=c("#32a852", "#1c00d1", "#d10000"))+
  guides(color=guide_legend(override.aes=list(fill=NA)))+
   scale_y_continuous(expand = c(0, 0), limits = c(-1, 13))+
   theme(axis.line = element_line(colour = 'black', size = 4),
         axis.ticks = element_line(colour= 'black', size = 4),
         axis.ticks.length = unit(21, "pt"),
         axis.ticks.x = element_blank(),
         panel.background = element_rect(fill = "white", colour = "white", linetype = "solid"))
dev.off()
    






