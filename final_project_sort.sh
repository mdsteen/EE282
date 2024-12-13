#For reference, the original data file used in this experiment is called IRC_merged_allCamData_thru_20240829.csv.Replace as necessary with your own file if the experiment is being recreated

#Sorting the data by species (making sure to keep the file header)
(head -n 1 IRC_merged_allCamData_thru_20240829.csv && tail -n +2 IRC_merged_allCamData_thru_20240829.csv | sort -t, -k2,2) > IRC_allCamData_SortedSpecies.csv

#The original data file has 14 total columns of data, some of which is unnecessary. The following code prints only the necessary data columns.
gawk -F ',' '{print $1 "," $2 "," $4 "," $6 "," $7 "," $12 ","}' IRC_allCamData_SortedSpecies.csv > IRC_SortedSpecies_modified.csv

#Sort the data by site location (column 6) within each species (column 2), still keepingthe header in tact
(head -n 1 IRC_SortedSpecies_modified.csv && tail -n +2 IRC_SortedSpecies_modified.csv | sort -t ',' -k2,2 -k6,6) > IRC_SortedSpecies_modified_site.csv

#Remove any columns with NA as an input value to clean up the data set further.
awk -F ',' '$2 != "NA" && $6 != "NA"' IRC_SortedSpecies_modified_site.csv > IRC_SortedSpecies_noNA.csv
