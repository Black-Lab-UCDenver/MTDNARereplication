#load libraries
library(ggplot2)

# set working directory
setwd("/path/to/files")

#load input files
#change the file name "1D.csv" to make a different fish dotplot figure
    FISHseries <- read.csv("1D.csv", sep=",")
    FISHseries$dose <- as.factor(FISHseries$dose)

#make dot plot of FISH data series   
    ggplot(FISHseries, aes(dose, green_red, fill = count, color = count)) + 
	geom_dotplot(binaxis = "y", 
		stackdir = "center", 
		stackratio = 0.2, 
		dotsize = 1, 
		method = "dotdensity", 
		binpositions = "bygroup", 
		binwidth = 0.07, 
		drop = TRUE, 
		position = position_jitter(width = 0, height = 0.03)) + 
	scale_y_continuous(limits=c(2.1,9), 
		breaks = seq(1.1, 9.9, by = 2.2)) + 
	theme(legend.position="none") + 
	scale_fill_manual(values=c("RED"," dodgerblue2","BLACK")) + 
	scale_color_manual(values=c("RED"," dodgerblue2","BLACK")) + 
	theme(axis.title.x=element_blank(), 
		axis.text.x=element_blank(),
		axis.ticks.x=element_blank(), 
		axis.title.y=element_blank(), 
		axis.text.y=element_blank(),
		axis.ticks.y=element_blank()) + 
	theme(panel.background = element_rect(fill = "white"),
		panel.grid.major=element_line(size=0.25,linetype='solid',color="grey"), 
		panel.grid.minor=element_line(size=0.25, linetype='solid',color="grey"), 
		panel.grid.major.x = element_blank())
    
#save the files
ggsave("1D.tiff", device="tiff", width =7.45, height =2.58 , units ="in" , dpi=300)
