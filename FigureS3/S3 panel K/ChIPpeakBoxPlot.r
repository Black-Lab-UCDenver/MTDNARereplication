#load libraries
library(ggplot2)


# set working directory
setwd("/path/to/files")

#load input files
    dataseries <- read.csv("S3K.txt", sep="\t")

#make box plot of peak data series   
ggplot(dataseries, aes(group=type,x=type, y=Score, fill = type, color = type)) + 
	geom_boxplot(fill = "white", 
		color = c("black","blue"), 
		lwd =0.5, 
		outlier.size = 0.5) + 
	theme_classic() + 
	theme(legend.position="none") + 
	theme(panel.background = element_rect(fill = "white")) + 
	theme(axis.text.x = element_text(face="bold", size=15), 
		axis.text.y=element_text(face="bold", size=14)) + 
	theme(axis.line = element_line(size = 1)) + 
	theme(axis.title.x = element_blank(), 
		axis.title.y=element_blank(), 
		axis.text.x=element_blank(), 
		axis.text.y=element_blank()) + 
	theme(axis.ticks=element_line(color="black"))
    
#save the files
ggsave("S3K.tiff", device = "tiff", width = 2, height = 2, units = "in", dpi = 300)
  
