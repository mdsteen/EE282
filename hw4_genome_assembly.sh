#Calculate the N50
hifiasm -o IS01_assembly -t 16 IS01_Hifi_AdaptorRem.40X.fasta.gz

awk '/^S/{print ">"$2; print $3}' IS01_assembly.bp.p_ctg.gfa > IS01_assembly.bp.p_ctg.fasta

bioawk -c fastx '{print length($seq)}' IS01_assembly.bp.p_ctg.fa | sort -n -r | awk '
BEGIN {
    total = 0; count = 0; sum = 0;
}
{
    total += $1;
    lengths[count++] = $1;
}
END {
    half_total = total / 2;
    running_sum = 0;
    for (i = 0; i < count; i++) {
        running_sum += lengths[i];
        if (running_sum >= half_total) {
            print "N50:", lengths[i];
            break;
        }
    }
}'



#Contiguity Plot
faSplitByN dmel-all-chromosome-r6.48.fasta dmel_split 10 | bioawk -c fastx '{print length($seq)}' dmel_split | sort -nr > FlyBase_contig.txt

bioawk -c fastx '{print length($seq)}' dmel-all-chromosome-r6.48.fasta | sort -nr > FlyBase_scaffold.txt

bioawk -c fastx '{print length($seq)}' IS01_assembly.bp.p_ctg.fa | sort -nr > IS01_contig.txt

plotCDF IS01_contig.txt FlyBase_contig.txt FlyBase_scaffold.txt  hw4_contigplot.png



#Compleasm Score
compleasm run -a IS01_assembly.bp.p_ctg.fa -o compleasm_hifiasm -t 16 -l diptera_odb10

compleasm run -a dmel-all-chromosome-r6.48.fasta -o compleasm_dmel -t 16 -l diptera_odb10

