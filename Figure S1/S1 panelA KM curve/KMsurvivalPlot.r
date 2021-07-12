#load libraries
library(splines)
library(survival)

# set working directory
setwd("/path/to/files")

#load input files
KMdata <-read.table("S1A.txt", sep="\t", header=TRUE)

#create survival data based on overall survival, amount of time and copy number of MT locus
survfit(Surv(time, dead) ~ copy_number, data=KMdata) -> surv1
survdiff(Surv(time,dead) ~ copy_number, data=KMdata) -> surv2

#make KM curve of data series and save tiff file   
tiff(filename="S1A.tiff",width = 500, height = 480, units = "px", compression = "none", res = 118.11)
plot(surv1, col=c("black","red"), xlim=c(0,400), axes=FALSE, lwd=4)
axis(side=1,lwd=4, at = c(0,100,200,300,400), pos=0)
axis(side=2,lwd=4, at = c(0,.25,.5,.75,1), pos=0)
dev.off()
  
