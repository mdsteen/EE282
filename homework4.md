#Homework 4: pipelines, plotting, genome assembly

author: Megan Steen

##Summarize partitions of a genome assembly

First, use ```wget https://ftp.flybase.net/releases/FB2022_05/dmel_r6.48/fasta/dmel-all-chromosome-r6.48.fasta.gz``` to downlaod the _Drosophilia melanogaster_ genome.

Before you can run the ```faSize``` command, you must run ```gzip -d dmel-all-chromosome-r6.48.fasta.gz``` to decompress the file.

###Summary for sequences less than/equal to 100kb

Use ```faFilter -maxSize=100000 dmel-all-chromosome-r6.48.fasta hw4_output_lessequal.fasta``` to partition the data into a file containing all sequences with less than or equal to 100kb.

Next, use ```faSize hw4_output_lessequal.fasta``` to get the genome summary. The results are given below:

1. Total number of nucleotides is 6178042.
2. Total number of Ns is 662593.
3. Total number of sequences is 1863.

###Summary for sequences greater than 100kb

Use ```faFilter -minSize=100001 dmel-all-chromosome-r6.48.fasta hw4_output_greaterto.fasta``` to partition the data into a file containing all sequences with greater than 100 kb.

Next, use ```faSize hw4_output_greaterto.fasta``` to get the genome summary. The results are given below:

1. Total number of nucleotides is 137547960.
2. Total number of Ns is 490385.
3. Total number of sequences is 7.

###Plots for the sequence summaries

##Genome Assembly


