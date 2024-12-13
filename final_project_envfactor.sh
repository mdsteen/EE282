#The following code was used to do the analysis of the various environmental factors that were the focus of this study

#Count unique outputs for each environmental factor
awk -F, '
BEGIN {
    OFS=",";
    # Map column numbers to environmental factor names
    env_names[3] = "shade";
    env_names[4] = "CameraTemp";
    env_names[5] = "isRaining";

    # Print header
    print "Species,SiteLocation,EnvironmentalFactor,UniqueOutputCount";
}
NR > 1 {
    for (i = 3; i <= 5; i++) {
        key = $2","$6","env_names[i];  # Use the environmental factor name in the key
        unique[key][$i]++;
    }
}
END {
    for (key in unique) {
        split(key, arr, ",");
        print arr[1], arr[2], arr[3], length(unique[key]);
    }
}' IRC_SortedSpecies_noNA.csv

#Sort the unique count outputs by location (column 2) within each species (column 1), keeping the header
{
    head -n 1 IRC_uniqout_count.txt;   # Extract the header
    tail -n +2 IRC_uniqout_count.txt | sort -t, -k1,1 -k2,2; # Sort the data
} > IRC_uniqout_count_sorted.txt

#Count occurences of each output
awk -F, '
BEGIN {
    OFS=",";
    # Map column numbers to environmental factor names
    env_names[3] = "shade";
    env_names[4] = "CameraTemp";
    env_names[5] = "isRaining";

    # Print header
    print "Species,SiteLocation,EnvironmentalFactor,OutputValue,Count";
}
NR > 1 {
    for (i = 3; i <= 5; i++) {
        key = $2","$6","env_names[i]","$i;  # Unique key with factor name
        counts[key]++;
    }
}
END {
    for (key in counts) {
        split(key, arr, ",");
        print arr[1], arr[2], arr[3], arr[4], counts[key];
    }
}' IRC_SortedSpecies_noNA.csv > IRC_occurrence_count.txt

#Sort the count occurences by location (column 2) within each species (column 1), keeping the header
{
    head -n 1 IRC_occurrence_count.txt;  # Extract the header
    tail -n +2 IRC_occurrence_count.txt | sort -t, -k1,1 -k2,2;  # Sort the data
} > IRC_occurrence_count_sorted.txt

#Temperature plots: The following code must be repeated for each species
#Extract the site and camera temp data (must do for each species)
awk -F ',' '$1 == "URCI" && $3 == "CameraTemp" {print $2, $4}' IRC_occurrence_count_sorted.txt > URCI_site_temp.txt

#Prepare R Data
data <- read.table("URCI_site_temp.txt", header = FALSE, col.names = c("Site", "CameraTemp"))

#Plotting
ggplot(data, aes(x = Site, y = CameraTemp)) +
  geom_boxplot() +
  labs(
    title = "Range of CameraTemp for Species URCI at Each Site",
    x = "Site Location",
    y = "Camera Temperature"
  ) +
  theme_minimal()

#Shade Analysis
#Extract site and shade data
​​awk -F ',' '$3 == "shade" {print $1, $2, $4, $5}' IRC_occurrence_count_sorted.txt > IRC_shade_data.txt

#Prepare R Data
data <- read.table("IRC_shade_data.txt", header = FALSE, col.names = c("Species", "Site", "ShadeValue", "Count"))

# Prepare data (convert ShadeValue to a factor for categorical coloring)
data$ShadeValue <- as.factor(data$ShadeValue)

# Summarize data (aggregate counts by Species, Site, and ShadeValue)
heatmap_data <- aggregate(Count ~ Species + Site + ShadeValue, data = data, sum)

#Creating the Plot
ggplot(heatmap_data, aes(x = Site, y = Species, fill = Count)) +                                            geom_tile(color = "white") +                                                                                scale_fill_gradient(                                                                                          low = "lightblue",  # Color for low values
    high = "darkblue",  # Color for high values
    na.value = "grey50" # Handle NA values, if present
  ) +
  facet_wrap(~ShadeValue, labeller = label_both) +
  labs(
    title = "Heatmap of Shade Value Counts",
    x = "Site Location",
    y = "Species",
    fill = "Count"
  ) +
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 90, hjust = 1)
  )

#Rain Analysis
#load the data
data <- read.table("IRC_occurrence_count_sorted.txt", header = TRUE, sep = ",")

# Filter for the "isRaining" environmental factor
isRaining_data <- subset(data, EnvironmentalFactor == "isRaining")

# Summarize counts for each Species, Site, and OutputValue
isRaining_summary <- aggregate(Count ~ Species + SiteLocation + OutputValue, data = isRaining_data, sum)

# Ensure OutputValue is treated as a factor (categorical variable)
isRaining_summary$OutputValue <- as.factor(isRaining_summary$OutputValue)

#Plotting
ggplot(isRaining_summary, aes(x = SiteLocation, y = Species, fill = Count)) +
  geom_tile(color = "white") +
  scale_fill_gradient(
    low = "lightblue",   # Color for low values
    high = "darkblue",   # Color for high values
    na.value = "grey50"  # Handle missing values
  ) +
  facet_wrap(~OutputValue, labeller = label_both) +
  labs(
    title = "Heatmap of Rain Output Counts",
    x = "Site Location",
    y = "Species",
    fill = "Count"
  ) +
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 90, hjust = 1)
  )
