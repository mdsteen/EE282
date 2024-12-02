# EE282 Final Project Report

author: Megan Steen

##Introduction
The general topic of my research is the effects of landscape on animal movement and behavior. The purpose of this project is to use bioinformatics to sort and analyze my data to see if various environmental factors are correlated with animal movement patterns. Additionally, I would like to determine if these environmental factors are correlated with biodiversity in the area, and to cross-compare species data to determine if the presence of various species influence others in the community. 

##Methods

###Step 1: Sorting the Data
First, use ```sort -t, -k2,2 IRC_merged_allCamData_thru_20240829.csv > IRC_allCamData_SortedSpecies.csv``` to sort all the raw data by species.

Next, use ```gawk -F, '{ $3=""; $5=""; $8=""; $9=""; $11=""; $13=""; print $0 }' IRC_allCamData_SortedSpecies.csv | sed 's/,,/,/g' > IRC_SortedSpecies_modified.csv``` to eliminate the unwanted columns of data. This leaves just the factors that I want to focus on: species, shade coverage, temperature, site location, date, and time of each recording.

##Results

##Discussion
