# This script will produce a circos plot for structural varients originating from the metallothionein locus to other chromosomes.
# As input it will accept the vcf output from gridss, turn it into a bedpe file, save the file, filter reads by location, 
# process the final reads and plot them as a circos plot. 

########Dependencies
library(readr)
library(dplyr)
library(StructuralVariantAnnotation)
library(rtracklayer)
library(circlize)


 #The path to the gridss vcf to be processed needs to be added here.
  vcf = readVcf("/path/to/.vcf")

  # Export breakpoints to BEDPE
  bpgr = breakpointRanges(vcf)

  #The directory where the bedpe should be saved needs to be added here.
  write.table(breakpointgr2bedpe(bpgr), file="/path/to/save/location/.bedpe", sep="\t", quote=FALSE, col.names=FALSE)
  
  #This script loads the saved bedpe, the path to this file needs to be added here.
  bedPe <- read_tsv("/path/to/save/location/.bedpe", col_names = FALSE)
  
  #The following script selects for SV pairs that originate within the MT locus.
  chr16Origin <- dplyr::filter(bedPe, X2=="chr16")
  chr16nonOrigin <- dplyr::filter(bedPe, X2!="chr16")
  chr16Insert <- dplyr::filter(chr16nonOrigin, X5=="chr16")
  
  metalloOrigin <- dplyr::filter(chr16Origin, X3>56520000 & X3<56720000)
  metalloInsert <- dplyr::filter(chr16Insert, X6>56520000 & X6<56720000)
  
  metalloSV <- rbind(metalloOrigin, metalloInsert)
  
  #The MT SVs are processed to ensure each clumn of data is in the correct order and listed as the correct class.
  breakData<- dplyr::select(metalloSV, -X1, -X8, X9, -X10, -X11)
  colnames(breakData)<-c("Chromosome", "chromStart", "chromStop", "Chromosome.1", "chromStart.1", "chromStop.1", "score")
  breakData$same <- ifelse(breakData$Chromosome==breakData$Chromosome.1, "yes", "no")
  breakData <- dplyr::filter(breakData, same!="yes")
  breakData$Chromosome <- as.factor(breakData$Chromosome)
  breakData$chromStart <- as.numeric(breakData$chromStart)
  breakData$chromStop <- as.numeric(breakData$chromStop)
  breakData$Chromosome.1 <- as.factor(breakData$Chromosome.1)
  breakData$chromStart.1 <- as.numeric(breakData$chromStart.1)
  breakData$chromStop.1 <- as.numeric(breakData$chromStop.1)
  breakData <- as.data.frame(breakData)
  
  breakData <- dplyr::filter(breakData, Chromosome !="pBR322")
  breakData <- dplyr::filter(breakData, Chromosome !="chrM")
  breakData <- dplyr::filter(breakData, Chromosome.1 !="pBR322")
  breakData <- dplyr::filter(breakData, Chromosome.1 !="chrM")

  
  bed1 <- dplyr::select(breakData, Chromosome, chromStart, chromStop)
  bed2 <- dplyr::select(breakData, Chromosome.1, chromStart.1, chromStop.1)
  
  bed1$Chromosome <- gsub("chr", "", bed1$Chromosome)
  bed2$Chromosome.1 <- gsub("chr", "", bed2$Chromosome.1)
  
  #Add the path tohg38 chrmosome sizes downloaded from ucsc here.
  chroms <- read_tsv("/path/to/hg38.chrom.sizes", col_names=FALSE)
  chroms$start <- 1
  colnames(chroms) <- c("name", "stop", "start")
  df1 <- dplyr::select(chroms, name, start, stop)
  
  
  #This series of transformations will process the chromosome files so they plot with the correct and and in the correct order.
  chr1 <- filter(df1, name=="chr1")
  chr2 <- filter(df1, name=="chr2")
  chr3 <- filter(df1, name=="chr3")
  chr4 <- filter(df1, name=="chr4")
  chr5 <- filter(df1, name=="chr5")
  chr6 <- filter(df1, name=="chr6")
  chr7 <- filter(df1, name=="chr7")
  chr8 <- filter(df1, name=="chr8")
  chr9 <- filter(df1, name=="chr9")
  chr10 <- filter(df1, name=="chr10")
  chr11 <- filter(df1, name=="chr11")
  chr12 <- filter(df1, name=="chr12")
  chr13 <- filter(df1, name=="chr13")
  chr14 <- filter(df1, name=="chr14")
  chr15 <- filter(df1, name=="chr15")
  chr16 <- filter(df1, name=="chr16")
  chr17 <- filter(df1, name=="chr17")
  chr18 <- filter(df1, name=="chr18")
  chr19 <- filter(df1, name=="chr19")
  chr20 <- filter(df1, name=="chr20")
  chr21 <- filter(df1, name=="chr21")
  chr22 <- filter(df1, name=="chr22")
  chrX <- filter(df1, name=="chrX")

  
  dfChromOrder <- data.frame(rbind(chr1, chr2, chr3, chr4, chr5, chr6, chr7, chr8, chr9, chr10, chr11, chr12, chr13, chr14, chr15, chr16, chr17, chr18, chr19, chr20, chr21, chr22, chrX))
  dfChromOrder$name <- gsub("chr", "", dfChromOrder$name)
  dfChromOrder$name = factor(dfChromOrder$name, levels=dfChromOrder$name)
  
  
  chrStart <- dplyr::select(dfChromOrder, name, start)
  chrStop <- dplyr::select(dfChromOrder, name, stop)
  colnames(chrStop) <- c("name", "start")
  
  plotChrom <- rbind(chrStart, chrStop)
  
  #Add the path to the directory to save the final plot here.
  tiff(file= "/path/to/final/plot/tiff", width = 1200, height= 1200, units="px")
  
  circos.par("track.height" = 0.1)
  circos.initialize(factors = plotChrom$name, x = plotChrom$start)
  
  circos.track(ylim = c(0, 0.5), track.height = cm_h(2), bg.col = 'black', panel.fun = function(x, y) {
    circos.text(CELL_META$xcenter, CELL_META$ylim[1], CELL_META$sector.index, 
                facing='bending.inside', adj=c(0.5, -0.25),
                cex = 3.5, col='white')
  })
  circos.genomicLink(bed1, bed2, border = "black")
  
  dev.off()
  circos.clear()
