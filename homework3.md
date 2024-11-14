#Homework 3 EE282

author: Megan Steen

## Summarize Genome Assembly

The working pipeline script can be found in the file hw3_genome_summary.sh, but detailed steps and the results are included below. 

### Step 1

First, use ```wget https://ftp.flybase.net/releases/FB2022_05/dmel_r6.48/fasta/dmel-all-chromosome-r6.48.fasta.gz``` to downlaod the _Drosophilia melanogaster_ genome. 

### Step 2
Check file integrity using checksums. Flybase uses md5sum, so you will use the following command to do this:
```md5sum  dmel-all-chromosome-r6.48.fasta.gz```

The above command gives the following identification line: be1f79c5922a4bf08548a2a4553e4d5f 

The identification above matches the one given on the flybase website, which means the file is in tact and not corrupted. 

### Step 3
Before you can run the ```faSize``` command, you must run ```gzip -d dmel-all-chromosome-r6.48.fasta.gz``` to decompress the file.

use ```faSize dmel-all-chromosome-r6.48.fasta``` to calculate a summary of the genome information.

By running the above command, you can determine the following:
1. the total number of nucleotides is 143726002
2. the total number of Ns is 1152978
3. the total number of sequences is 1870

## Summarize an Annotation File

The working pipeline script can be found in the file hw3_annotation_summary.sh, but detailed steps and the results are included below.

### Step 1
First, use ```wget https://ftp.flybase.net/releases/FB2022_05/dmel_r6.48/gtf/dmel-all-r6.48.gtf.gz``` to download the _Drosophilia melanogaster_ gtf file.

### Step 2
Check file integrity using checksums. Flybase uses md5sum, so you will use the following command to do this: 
```md5sum dmel-all-r6.48.gtf.gz```

The above command gives the following identification line: e13fa4e210bb47378ac2797cf78d69b3

The identification above matches the one given on the flybase website, which means the file is in tact and not corrupted.

### Step 3
Before you can run the ```bioawk``` command, you must run ```gzip -d dmel-all-r6.48.gtf.gz``` to decompress the file.

Additionally, the data must be sorted so the results from bioawk are accurate. Use ```sort dmel-all-r6.48.gtf > sorted_dmel-all-r6.48.gtf``` to sort the file and direct the sort output to a new file.

Now the bioawk command can be run. Use ```bioawk -c gff '{print $3}' sorted_dmel-all-r6.48.gtf | sort | uniq -c | sort -nr``` to get the total number of features of each type, sorted from the most common to least common. Here are the results: 

190050 exon
 163242 CDS
  46802 5UTR
  33738 3UTR
  30885 start_codon
  30825 stop_codon
  30799 mRNA
  17896 gene
   3053 ncRNA
    485 miRNA
    365 pseudogene
    312 tRNA
    300 snoRNA
    262 pre_miRNA
    115 rRNA
     32 snRNA

Now, use ```bioawk -c gff '$3 == "gene" {print $1 $7}' sorted_dmel-all-r6.48.gtf | sort | uniq -c | sort -nr``` to get the total number of genes per chromosome arm. Here are the results:

   2120 3R-
   2107 3R+
   1834 2R-
   1825 2L+
   1819 2R+
   1746 3L+
   1743 3L-
   1690 2L-
   1394 X-
   1314 X+
     64 Y+
     58 4-
     56 4+
     49 Y-
     24 mitochondrion_genome+
     20 rDNA+
     14 mitochondrion_genome-
      2 211000022280494-
      1 Unmapped_Scaffold_8_D1580_D1567-
      1 Unmapped_Scaffold_8_D1580_D1567+
      1 rDNA-
      1 211000022280703+
      1 211000022280481+
      1 211000022280347-
      1 211000022280341-
      1 211000022280328-
      1 211000022279681+
      1 211000022279392-
      1 211000022279264-
      1 211000022279188+
      1 211000022279165-
      1 211000022278760-
      1 211000022278449-
      1 211000022278436-
      1 211000022278279-


 
