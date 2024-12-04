#This code is used to calculate site visitation frequency and to determine which sites each species visit the most and least.

#Counts how many entries of each species/site pairing there are.
gawk -F, '{print $2 "," $7}' IRC_SortedSpecies_modified_site.csv | uniq -c > species_site_counts.txt

#Calculates the percent frequency of visits for each species/site pairing.
awk -F, '{split($1, arr, " "); count[arr[2]] += arr[1]; site[arr[2]","$2] += arr[1]} END {for (species in count) {for (site_name in site) if (site_name ~ species) print site_name, (site[site_name]/count[species])*100 "%"}}' species_site_counts.txt

awk -F, '{split($1, arr, " "); count[arr[2]] += arr[1]; site[arr[2]","$2] += arr[1]} END {for (species in count) {for (site_name in site) if (site_name ~ species) print site_name, (site[site_name]/count[species])*100 "%"}}' species_site_counts.txt | sort
