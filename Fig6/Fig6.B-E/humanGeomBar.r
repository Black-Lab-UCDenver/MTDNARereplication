#This script will output the bar graph that makes figure 6b, as input it receives the blastn output file, homology.tsv.
library(dplyr)
library(readr)

dfIN <-read_tsv("/path/to/homology.tsv", col_names = TRUE)



seq <- filter(dfIN, SeqNegLogEval!=0)
scram <- filter(dfIN, ScramNegLogEval!=0)
randG <- filter(dfIN, RandGNegLogEval!=0)

seqLength <- length(seq$SeqQstart)
scramLength <- length(scram$SeqQstart)
randGLength <- length(randG$SeqQstart)
 
totalHomology <- c(seqLength, scramLength, randGLength)
sample <- c("seq", "scram", "randG")

plotdata <- data.frame(totalHomology, sample)

plotdata$order <- ifelse(plotdata$sample =="seq", "1", ifelse(plotdata$sample=="scram", "2", "3"))
plotdata$order <- as.factor(plotdata$order)



tiff(filename = "/path/to/HomologyCount.tiff", height = 1200, width = 800, units="px")

ggplot(plotdata, aes(x=order, y=totalHomology, color=sample))+
  geom_bar(stat="identity", size = 4, fill= "white")+
  scale_color_manual(values=c("#32a852", "#1c00d1", "#d10000"))+
  guides(color=guide_legend(override.aes=list(fill=NA)))+
  scale_y_continuous(expand = c(0, 0), limits = c(-1, 150 ))+
  theme(axis.line = element_line(colour = 'black', size = 4),
        axis.ticks = element_line(colour= 'black', size = 4),
        axis.ticks.length = unit(21, "pt"),
        panel.background = element_rect(fill = "white", colour = "white", linetype = "solid"))

dev.off()
