#Sort the original file by species.
sort -t, -k2,2 IRC_merged_allCamData_thru_20240829.csv > IRC_allCamData_SortedSpecies.csv

#Remove unwanted columns of data from the sorted csv file.
gawk -F ',' '{print $1 "," $2 "," $4 "," $6 "," $7 "," $10 "," $12","}' IRC_allCamData_SortedSpecies.csv > IRC_SortedSpecies_modified.csv

#Sort by site location (column 7) within each species (column 2).
sort -t ',' -k2,2 -k7,7 IRC_SortedSpecies_modified.csv > IRC_SortedSpecies_modified_site.csv
