#download the data from flybase
wget https://ftp.flybase.net/releases/FB2022_05/dmel_r6.48/fasta/dmel-all-chromosome-r6.48.fasta.gz

gzip -d dmel-all-chromosome-r6.48.fasta.gz



#partitioning the data

faFilter -maxSize=100000 dmel-all-chromosome-r6.48.fasta hw4_output_lessequal.fasta #partition lessequal

faSize hw4_output_lessequal.fasta #for genome summary

faFilter -minSize=100001 dmel-all-chromosome-r6.48.fasta hw4_output_greaterto.fasta #partition greater to

faSize hw4_output_greaterto.fasta #for genome summary


#For the following plots, make sure to run the code for both of the partitioned files.
#Sequence length distribution plots

bioawk -c fastx '{print length($seq)}' hw4_output_lessequal.fasta | sort | unique -c > hw4_seqlength_lessequal.txt

R

library(ggplot2)

data <- read.table("hw4_seqlength_lessequal.txt", header = FALSE)

colnames(data) <- c("count", "length")

ggplot(data, aes(x = length)) +
  geom_histogram(binwidth=0.05, color = "black", fill = "blue") +  # Bar plot
  scale_x_log10() +  # Log scale for the x-axis
  labs(title = "Sequence Length Distribution (Log Scale)",
       x = "Sequence Length (Log Scale)",
       y = "Count") +
  theme_minimal()



#Sequence GC% Distribution Plots

bioawk -c fastx '{print $name, gc($seq)}' hw4_output_lessequal.fasta > hw4_gc_lessequal.txt

R

library(ggplot2)

data_gc_lessequal <- read.table("hw4_gc_lessequal.txt", header = FALSE, col.names = c("sequence", "gc_percent"))

ggplot(data_gc_lessequal, aes(x = gc_percent)) +
  geom_histogram(binwidth = 0.05, color = "black", fill = "blue", alpha = 0.7) +
  labs(title = "GC Content Distribution", x = "GC Content (%)", y = "Frequency") +
  theme_minimal()



#Cumulative plotCDF
bioawk -c fastx '{print length($seq)}' hw4_output_lessequal.fasta | sort -nr > hw4_cumul_lessequal.txt

plotCDF hw4_cumul_lessequal.txt Plot_CDF_lessequal

bioawk -c fastx '{print length($seq)}' hw4_output_greaterto.fasta | sort -nr > hw4_cumul_greaterto.txt

plotCDF hw4_cumul_greaterto.txt Plot_CDF_greaterto

