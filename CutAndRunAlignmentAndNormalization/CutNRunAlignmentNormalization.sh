#CUT&RUN alingment and data normalization
#File paths will need to be replaced with the correct path on your local machine for these programs to function correctly.

#Trim adapters using bbduk, align paried-end data using bowtie2
/path/to/bbduk.sh in1=/path/to/*R1_001.fastq in2=/path/to/*R2_001.fastqq out=*trimmed_R1_001.fastq out2=*trimmed_R2_001.fastq ref=/path/to/adapters.fa ktrim=r k=23 mink=11 hdist=1 tpe tbo \
bowtie2 -x /path/to/hg38_mg1655_combine -1 *trimmed_R1_001.fastq -2 *trimmed_R2_001.fastq -S sample_trimmed.sam \
#
#Filter reads with >=150 insert length, turn the resulting sam file into a bam file, sort and index the bam file, get alignment stats.
&& samtools view -h sample_trimmed.sam | \
  awk 'substr($0,1,1)=="@" || ($9>=150) || ($9<=-150)' | \
  samtools view -b > sample_trimmed_150.bam \
&& samtools sort sample_trimmed_150.bam -o sample_trimmed_150-sorted.bam \
&& samtools index sample_trimmed_150-sorted.bam \
&& samtools idxstats sample_trimmed_150-sorted.bam > sample_trimmed_150-sorted-stats.txt \
#
#Create coverage bigwig file using deeptools bamCoverage, change scaleFactor accordingly.
&& bamCoverage -b sample_trimmed_150-sorted.bam -o sample_trimmed_150-sorted.bw --scaleFactor 1.0 --normalizeUsing CPM \
#
#merge multiple bigwigs using wiggletools (can add additional .bw to the list) and convert back to bigwig.
&& wiggletools mean *sample1.bw *sample2.bw | wigToBigWig stdin /path/to/hg38_mg1655_combine.chr.sizes merged.bw \
