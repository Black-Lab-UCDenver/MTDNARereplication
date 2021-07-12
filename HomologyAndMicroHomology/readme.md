Using the gridss calls from the alignment and normalizarion pipeline, the first step in determining the homology between the origina and insertion site is to turn the VCF output into a bedPe file. 

gridssVCFtoBedpe.r

Next, isolate the reads of interest by looking for SVs that either originate or insert in the cup1 locus in yeast, or the MT lucus in humans. Label the MT or CUP aspects of the SV pairs as origins and the other chromosomal regions as insertions. Give the SV pairs a common name to keep track of which origin is paried with which insertion and save the these are separate bed files. In this script, the region of interest and chromosome names will need to be changed depending on the organism and region of interest. This is also where SVs can be fitered by score and the sixe of the region for homology or micro homology is dtermined.

bedPEVarientProcessing.r

At this point there are should be two bed files in a directory, one with the insertions and one with the origins. The next step is to use bedtools to get the fasta files for each of these. One way to do this to output each the fasta for each origin as it's own fasta file, put each of these files into it's own directory, and then repreat the process for the insertions. Since the insertions and the origins share the same name, you can use this feature to ensure they are saved to the same directory.

To get the fasta for the origins:
GetFastaForBedOrigins.sh

Split these into individual files, then put them into their own directory named after themselves:
splitFasta.sh
putAllFilesIntoTheirOwnSubDir.sh

To get the insertion fastas use the same script for the origins, but change the file name to inseetions file:
GetFastaForBedOrigins.sh

The next step is to create the scrambled control. In doing so both the origin and the insertion and scrambled control be saved to the same directory as the corresponding origin of the same name.

sequenceScrambler.r

To create the randome genomic control regions, start by randomly selecting 1000 regions of a desired size using the chromosome sizes as a template. Ensure them ythese regions do not cross the boundaries of the ends of the chromsomes. Get the fasta files for each of these regions using the same script as the Origins, and then randomly assign one randome genomic region to an Origin directory.

To generate the random regions, use the following script:
random.chrom.r

To get the fasta files for these regions use the same scripts as for the origins, changing the file names and directories as needed to work for the random regions.
To get the fasta for the origins:
GetFastaForBedOrigins.sh

Split these into individual files, then put them into their own directory named after themselves:
splitFasta.sh 
putAllFilesIntoTheirOwnSubDir.sh

Now, randomly save one random genomic region in each origin directory:
RandGenome.r

Apply blastn to each origin directory to look for homology or microhomology using the origin as the blast database, and the insertion, scramble insertion, or randome genomic files as the querry.
 
 For homology use:
 applyBlastnToAllSubDirs.sh
 
 For microhomology use:
 microHomology.sh
 
Sometimes blastn cannot read the file names due to the use of specific characters. You may need to use the followinf script to remove these characters from the file names:
 replaceFileNameCharacters.sh
 
 Column names will need to be added to each homology output, and all the outputs will need to be aggregated into a final document for analysis.
 
 Add column names with this script:
 addColNamesToHomOutput.r
 
Assemble the final output with the following script:
assembleFinalOutput.r









