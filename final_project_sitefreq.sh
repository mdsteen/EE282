#This code is used to calculate the site visitation frequency of each species/site pairing. In other words, this is how much each species visits each site.
#This can be used to determine what sites are visited most and least for each species

#Counts total site visits for each species/site pairing.
gawk -F, '{print $2 "," $6}' IRC_SortedSpecies_noNA.csv | uniq -c > species_site_counts.txt

#Counts total site visits for each species
gawk -F, 'NR > 1 {print $2}' IRC_SortedSpecies_noNA.csv | uniq -c > species_sitetotal_counts.txt

#Calculates percent frequency visitation for each species/site pairing.
awk -F, '{split($1, arr, " "); count[arr[2]] += arr[1]; site[arr[2]","$2] += arr[1]} END {for (species in count) {for (site_name in site) if (site_name ~ species) print site_name, (site[site_name]/count[species])*100 "%"}}' species_site_counts.txt > IRC_site_frequency.txt

#The following code is used to plot site visitation count in a stacked bar chart

#Edit formatting of txt file for R optimization
gawk -F, '{print $2 "," $6}' IRC_SortedSpecies_noNA.csv | uniq -c | sed  's/^ *//g' | sed 's/ /,/g' > species_site_counts.txt

#Extract data in R
data <- read.table("species_site_counts.txt", header = TRUE, sep = ",")
colnames(data) <- c("Count", "Species", "Site")

#Create the plot
ggplot(data, aes(x = Site, y = Count, fill = Species)) +
  geom_bar(stat = "identity") +  # Use 'identity' because we're specifying y values (Count)
  labs(
    title = "Species Counts by Site Location",
    x = "Site Name",
    y = "Count of Visits",
    fill = "Species"
  ) +
  theme_minimal()

