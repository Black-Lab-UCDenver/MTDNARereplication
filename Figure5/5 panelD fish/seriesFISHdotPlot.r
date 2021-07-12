#load libraries
library(ggplot2)

# set working directory
setwd("/path/to/files")

#load input files
VE821ser_UNC_VE821_FISH <- read.csv("231inhibitorVE821-unc+VE821.csv", sep=",")
VE821ser_UNC_VE821_FISH$dose <- as.factor(VE821ser_UNC_VE821_FISH$dose)

#make dot plot of FISH data series   
ggplot(VE821ser_UNC_VE821_FISH, aes(dose, green_red, fill = count, color = count)) + 
geom_dotplot(binaxis = "y", 
	stackdir = "center", 
	stackratio = 0.2, 
	dotsize = 0.8, 
	method = "dotdensity", 
	binpositions = "bygroup", 
	binwidth = 0.07, 
	drop = TRUE, 
	position = position_jitter(width = 0, height = 0.03)) + 
scale_y_continuous(limits=c(2.1,6), breaks = seq(1.1, 9.9, by = 2.2)) + 
theme(legend.position="none") + 
scale_fill_manual(values=c("RED","dodgerblue2","BLACK")) + 
scale_color_manual(values=c("RED","dodgerblue2","BLACK")) + 
theme(axis.title.x=element_blank(), 
	axis.text.x=element_blank(),
	axis.ticks.x=element_blank(), 
	axis.title.y=element_blank(), 
	axis.text.y=element_blank(),
	axis.ticks.y=element_blank()) + 
theme(panel.background = element_rect(fill = "white"),
	panel.grid.major=element_line(size=0.25,linetype='solid',color="grey"),
	panel.grid.minor=element_line(size=0.25,linetype='solid',color="grey"), 
	panel.grid.major.x = element_blank())
    
#save the files
ggsave("5D.tiff", device="tiff", width =3.53, height =2.61 , units ="in" , dpi=300)
  
