#ReRepSeq alingment and data normalization and gridss SV calls
#File paths will need to be replaced with the correct path on your local machine for these programs to function correctly.
#
#This script will output all intermediate files as well as a final normalized, blacklisted, and bined  bedgraph
#
#Align paried-end data using BWA
bwa mem /path/to/hg38Chroms.fa *1.fq.gz *2.fq.gz > sample.sam \
#
#Turn the resulting sam file into a bam file, sort and index the bam file, get alignment stats.
&& samtools view -bS sample.sam > sample.bam \
&& samtools sort sample.bam -o sort.sample.bam \
&& samtools index sort.sample.bam \
&& samtools idxstats sort.sample.bam > Sample.stats.txt \
#
#Remove duplicate reads, sort and index the resulting file.
&& samtools rmdup -s sort.sample.bam rmdup.sort.sample.bam \
&& samtools sort rmdup.sort.sample.bam -o sort.rmdup.sample.bam \
&& samtools index sort.rmdup.sample.bam \
#
#Get global and chromosomal alignment stats. 
&& samtools flagstat sort.rmdup.sample.bam >stats.txt \
&& samtools idxstats sort.rmdup.sample.bam >stats.chrom.txt \
#
#Get SV calls using GRIDSS. See https://github.com/PapenfussLab/gridss for indepth usage.
#Note that gridss SV calls are made prior to data normalization, so this script will work for dna-seq pipelines in general.
&& /path/to/gridss-2.8.0/gridss.sh -j /path/to/gridss-2.8.0/gridss-2.8.0-gridss-jar-with-dependencies.jar -r /path/to/hg38Chroms.fa -o gridss.vcf --maxcoverage 1000000000 --assembly gridss.bam sort.rmdup.sample.bam \
#
#Remove reads from black listed regions prior to data normalization, putting black listed reads into a separate file, get stats on remaining read counts, sort, and index the resulting bam files.
&& samtools view -b -L /path/to/noMetalloBL.txt -U sample.bl.bam sort.rmdup.sample.bam > blackListReads.bam \
&& samtools sort blackListReads.bam -o sort.blackListReads.bam \
&& samtools index sort.blackListReads.bam \
&& samtools idxstats sort.blackListReads.bam > blackListStats.txt \
&& samtools sort sample.bl.bam -o sort.sample.bl.bam \
&& samtools index sort.sample.bl.bam \
#
#Turn the final bam file into a bedgraph
&& bedtools genomecov -ibam sort.sample.bl.bam -bga > sample.bl.bg \
#
#Use R to rpm normalize and normalize to mitochondria reads. This will output a file called Sample.rpmMito.bedgraph
#For other experimental designs, the normalization can be changed to the appropriate method by opening the r scipt and making the necessary changes.
&& Rscript /path/to/rpmMitoNorm.r \
#
#Re-bin the final bedgraph to 1kb. Note changing the math will change bin sizes. 
&& rm -f tmp.db && awk 'BEGIN {printf("create table T(C TEXT,S INT,E INT,V INT); BEGIN TRANSACTION;\n");}{printf("INSERT INTO T(C,S,E,V) VALUES(\"%s\",%s,%d,%s);\n",$1,$2,$3,$4);} END {printf("COMMIT; SELECT C,(S/1000)*1000 as G,((S/1000)+1)*1000,AVG(V) FROM T GROUP BY C,G;");}' Sample.rpmMito.bedgraph | sqlite3 -separator $'\t' tmp.db > sample.rpmMito.1kbBin.bedgraph && rm -f tmp.db
