for d in ./*/ ; do (cd "$d" && blastn -word_size 4  -query *.RandGenome.fasta -outfmt '10 qseqid sseqid qstart qend sstart send qseq sseq evalue bitscore score length pident nident mismatch positive gapopen gaps ppos' -strand 'both' -task 'blastn' -db *.fa -out out.RandG.csv -evalue '1'); done

