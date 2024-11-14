wget https://ftp.flybase.net/releases/FB2022_05/dmel_r6.48/fasta/dmel-all-chromosome-r6.48.fasta.gz\
|md5sum dmel-all-chromosome-r6.48.fasta.gz\
|gzip -d dmel-all-chromosome-r6.48.fasta.gz\
|faSize dmel-all-chromosome-r6.48.fasta
