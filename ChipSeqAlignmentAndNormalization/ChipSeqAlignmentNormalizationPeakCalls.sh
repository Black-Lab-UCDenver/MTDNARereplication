#ChIP-Seq alingment and data normalization
#File paths will need to be replaced with the correct path on your local machine for these programs to function correctly.

#Align paried-end data using bowtie2
bowtie2 -x /path/to/hg38_dm3_combine -1 *R1_001.fastq -2 *R2_001.fastq -S sample.sam \
#
#Turn the resulting sam file into a bam file, sort and index the bam file, get alignment stats.
&& samtools view -bS sample.sam > sample.bam \
&& samtools sort sample.bam -o sample-sort.bam \
&& samtools index sample-sort.bam \
&& samtools idxstats sample-sort.bam > sample-stats.txt \
#
# filter only chr1-22 and chrX using samtools
&& samtools view -b sample-sort.bam chr1 chr2 chr3 chr4 chr5 chr6 chr7 chr8 chr9 chr10 chr11 chr12 chr13 chr14 chr15 chr16 chr17 chr18 chr19 chr20 chr21 chr22 chrX > sample-mainchr.bam \
# Get random subset of reads using samtools view
# x.y uses x as basis of randomization (use same value for all files) and y as proportion of reads to retain
# check the number of reads pulled using samtools view -bs x.y sample-mainchr.bam | wc -l
&& samtools view -h -s x.y sample-mainchr.bam > sample-subset.bam \
#
#Sort and index the bam file, get alignment stats.
&& samtools sort sample-subset.bam -o sample-subset-sorted.bam \
&& samtools index sample-subset-sorted.bam \
&& samtools idxstats sample-subset-sorted.bam > sample-subset-sorted-statstxt \
#Create coverage bigwig file using deeptools bamCoverage, change scaleFactor accordingly.
&& bamCoverage -b sample-subset-sorted.bam -o sample-subset-sorted.bw --scaleFactor 1.0 --normalizeUsing CPM \
#
# get correlation between control and treatment H3K27me3 ChIP bigwigs using deep tools
# BigwigSkip.bed contains all chromosomes not chr1-22 or chrX, any location not removed when filtering
# can add argument --region for specific locus
&& multiBigwigSummary bins -b control.bw treatment.bw -bs=50 -bl BigwigSkip.bed -o trackcomparison.npz \
&& plotCorrelation --corData trackcomparison.npz --corMethod pearson --whatToPlot scatterplot --plotFile plot.pdf \
#
# create bedGraph of sample-subset-sorted.bam to use in peak calling
# call peaks using epic2 with K27me3 ChIP bed as treatment and Input bed as control
&& bedtools bamtobed -i sample-subset-sorted.bam > sample-subset-sorted.bed \
&& epic2 --treatment K27me3.bed --control Input.bed --genome hg38 > epic peaks.txt \
