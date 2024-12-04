# EE282 Final Project Report

author: Megan Steen

##Introduction
The general topic of my research is the effects of landscape on animal movement and behavior. The purpose of this project is to use bioinformatics to sort and analyze my data to see if various environmental factors are correlated with animal movement patterns. Additionally, I would like to determine if these environmental factors are correlated with biodiversity in the area, and to cross-compare species data to determine if the presence of various species influence others in the community. 

##Methods

###Sorting the Data
To eliminate excess data and organize the necessary variables for analysis, sorting the data is key. To begin, columns that are unnecessary for my analysis were removed from the data file to tidy up the original data set. Next, the data was sorted two times: once by species, and then further by site location. The code used can be found in the file final_project_sort.sh. 

First, use ```sort -t, -k2,2 IRC_merged_allCamData_thru_20240829.csv > IRC_allCamData_SortedSpecies.csv``` to sort all the raw data by species.

Next, use ```$gawk -F ',' '{print $1 "," $2 "," $4 "," $6 "," $7 "," $10 "," $12","}' IRC_allCamData_SortedSpecies.csv > IRC_SortedSpecies_modified.csv``` to eliminate the unwanted columns of data. This leaves just the factors that I want to focus on: species, shade coverage, temperature, site location, date, and time of each recording.

Additionally, to make later analysis easier, further sort the data by site location (column 7) within a species (column 2) Using ```sort -t ',' -k2,2 -k7,7 IRC_SortedSpecies_modified.csv > IRC_SortedSpecies_modified_site.csv```

###Calculate Site Visitation Frequency
Counts total for each species/site pair
```gawk -F, '{print $2 "," $7}' IRC_SortedSpecies_modified_site.csv | uniq -c > species_site_counts.txt```

Counts total site visits per species
```gawk -F, 'NR > 1 {print $2}' IRC_SortedSpecies_modified_site.csv | uniq -c > species_sitetotal_counts.txt```

Calculates percent frequency visitation for each species/site pair
```awk -F, '{split($1, arr, " "); count[arr[2]] += arr[1]; site[arr[2]","$2] += arr[1]} END {for (species in count) {for (site_name in site) if (site_name ~ species) print site_name, (site[site_name]/count[species])*100 "%"}}' species_site_counts.txt```

###Determining the influence of Environmental Factors on Animal Locomotion

##Results

##Discussion
