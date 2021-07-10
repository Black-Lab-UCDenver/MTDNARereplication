#This program accepts the homology output from blastn to generate figures to analyze various metrics of homology.



library(readr)
library(dplyr)
library(ggplot2)


#add the path to the location of the homology file here. 
dfIn <- read_tsv("/path/to/homology.tsv", col_names = TRUE)

colnames(dfIn) <- c("SeqQstart", "SeqQend", "SeqSstart", "SeqSend", "SeqEvalue", "ScramQstart",
                    "ScramQend", "ScramSstart", "ScramSend", "ScramEvalue", "RandGQstart",
                    "RandGQend", "RandGSstart", "RandGSend", "RandGEvalue", "SeqNegLogEval",
                    "ScramNegLogEval", "RandGNegLogEval")


seqDiff <- as.data.frame(abs(dfIn$SeqSstart - dfIn$SeqSend))
seqDiff$eval <- dfIn$SeqNegLogEval
seqDiff$sample <- "seq"
seqDiff$order <- 1
colnames(seqDiff) <- c("length", "eval", "sample", "order")

scramDiff <- as.data.frame(abs(dfIn$ScramSstart - dfIn$ScramSend))
scramDiff$eval <- dfIn$ScramNegLogEval
scramDiff$sample <- "scram"
scramDiff$order <- 2
colnames(scramDiff) <- c("length", "eval", "sample", "order")

RandGDiff <- as.data.frame(abs(dfIn$RandGSstart - dfIn$RandGSend))
RandGDiff$eval <- dfIn$RandGNegLogEval
RandGDiff$sample <- "randG"
RandGDiff$order <- 3
colnames(RandGDiff) <- c("length", "eval", "sample", "order")


diffOut <- rbind(seqDiff, scramDiff, RandGDiff)
diffOut[is.na(diffOut)] <- 0
diffOutNo0 <- filter(diffOut, length >0 )


seqDiff[is.na(seqDiff)] <- 0
diffOutNo0 <- filter(diffOut, length >0 )




#Add the path to location where you want each figure saved.

tiff(filename = "/path/to/HomLength.tiff", height = 1200, width = 800, units="px")

ggplot(diffOutNo0, aes(order, length, group = sample, colour = sample))+
  geom_boxplot(size=4, outlier.size=4)+
  scale_color_manual(values=c("#32a852", "#1c00d1", "#d10000"))+
  guides(color=guide_legend(override.aes=list(fill=NA)))+
  # scale_x_continuous(expand = c(0, 0))+ 
  scale_y_continuous(expand = c(0, 0), limits = c(-5, 510))+
  theme(axis.line = element_line(colour = 'black', size = 4),
        axis.ticks = element_line(colour= 'black', size = 4),
        axis.ticks.length = unit(21, "pt"),
        panel.background = element_rect(fill = "white", colour = "white", linetype = "solid"))

dev.off()

tiff(filename = "/path/to/HomEval.tiff", height = 1200, width = 800, units="px")

ggplot(diffOutNo0, aes(order, eval, group = sample, colour = sample))+
  geom_boxplot(size=4, outlier.size=4)+
  scale_color_manual(values=c("#32a852", "#1c00d1", "#d10000"))+
  guides(color=guide_legend(override.aes=list(fill=NA)))+
  # scale_x_continuous(expand = c(0, 0))+ 
  scale_y_continuous(expand = c(0, 0), limits = c(-3, 155))+
  theme(axis.line = element_line(colour = 'black', size = 4),
        axis.ticks = element_line(colour= 'black', size = 4),
        axis.ticks.length = unit(21, "pt"),
        panel.background = element_rect(fill = "white", colour = "white", linetype = "solid"))
dev.off()










