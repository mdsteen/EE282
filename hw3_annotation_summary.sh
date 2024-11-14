wget https://ftp.flybase.net/releases/FB2022_05/dmel_r6.48/gtf/dmel-all-r6.48.gtf.gz\
|md5sum dmel-all-r6.48.gtf.gz\
|gzip -d dmel-all-r6.48.gtf.gz\
|sort dmel-all-r6.48.gtf > sorted_dmel-all-r6.48.gtf\
|bioawk -c gff '{print $3}' sorted_dmel-all-r6.48.gtf | sort | uniq -c | sort -nr | tee >(bioawk -c gff '$3 == "gene" {print $1 $7}' sorted_dmel-all-r6.48.gtf | sort | uniq -c | sort -nr)

