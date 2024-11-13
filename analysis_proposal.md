# Analysis Proposal for EE282 Final Project

Author: Megan Steen

## Introduction

The general topic of my research is the effects of landscape on animal movement and behavior. Specifically, I aim to determine if different abiotic aspects of the environment, such as terrain, shade coverage, seasonality, and temperature have any influence on various animal’s movement and locality throughout southern california. To do this, my lab has motion-capturing trail cameras set up to gain insight on individuals across various locations in Silverado Canyon, Orange County. These cameras also capture a wide variety of data, such as the date, time, and temperature of the surrounding area for each video that is captured, which can all be used to learn more about the animals’ habitats. Past research has focused on genetic influences on animal behavior, but there is a lack of focus on abiotic aspects compared to these topics. This is essential to understanding communities as a whole and how both the abiotic and biotic factors in an area create a unique environment.

## Proposal

For my bioinformatics project I would like to create a way to sort and analyze my data to see if different environmental factors are correlated with animal movement patterns. Additionally, I would like to determine if these environmental factors are correlated with biodiversity in the area, and to cross-compare species data to determine if the presence of various species influence others in the community. To begin, I will sort and filter through my lab’s existing data set. My current data set numbers around 3800 videos, with a total of seven different species being represented across eight locations. Additionally, my data set consists of 14 categories of data, some of which are not the factors I wish to focus on. I will reduce the amount of data I have to go through using gawk or perl filtering to get rid of the columns I do not need. Once the excess data has been removed, I will sort the data by species, and within each species I would like to further sort the data by location of the recording. The above steps will leave me with neatly organized camera data of only the factors I want to focus on: species, shade coverage, temperature, and the site, date, and time of each recording. For my purposes, it is important to note that the different sites act as an environmental factor because they represent different terrain types the animals can encounter. 

The next step of my project would be to determine the correlation between biodiversity and different aspects of the landscape on movement patterns. To do this, I would calculate the frequency of species visits to each site using basic pipelines to run the calculations for each species. Next, I would like to determine if one or more of the various abiotic aspects are favored at each site using similar calculations; I can comb through the data using “if, then” statements to determine if the animals visit sites with specific abiotic factors more than others. Finally, to bring in the biodiversity aspect of the project, RStudio can be used to create graphs to visualize the results for each species, which can then be examined to determine if there is a connection between species at each location.

One last step of the project would be to incorporate automated gait analysis to determine if the various abiotic aspects being studied have an influence on speed of movement. Gait patterns, and thus the speed of movement, is important when studying animal movement and behavior because it can be linked to a variety of external influences which can give insight into how an organism interacts with its environment (Abourachid, 2003). An existing open-source pipeline called “ezTrack” can be used to automate location tracking and freeze modeling for the trail-cam videos. The results from the automated analysis can be compared to the abiotic factors to determine if the landscape had any influence on gait patterns and animal movement as a whole. 

## References

Anick Abourachid. (2003). A new way of analysing symmetrical and asymmetrical gaits in quadrupeds. Comptes Rendus. Biologies, Volume 326 (2003) no. 7, pp. 625-630. 

Pennington ZT, Dong Z, Feng Y, Vetere LM, Page-Harley L, Shuman T, Cai DJ (2019). ezTrack: 	An open-source video analysis pipeline for the investigation of animal behavior. Scientific Reports: 9(1): 19979

