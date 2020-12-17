# Problem Definition

## Background

Evolutionary theory predicts that a balanced sex ratio should be maintained by frequency-dependent selection. Organisms with environmental sex determination, however, are vulnerable to maladaptive sex ratios, because environmental conditions vary spatio-temporally. For reptiles with temperature-dependent sex determination (TSD), nest-site choice is a behavioural maternal effect that could respond to sex-ratio selection, as mothers could adjust offspring sex ratios by choosing nest sites that will have particular thermal properties. 

## Data

The data used here, was collected to directly test the hypothesis that females choose nest sites to alter the incubation temperature, perhaps influencing the sex-ratio of their offspring. To measure nest site temperature, physiological [devices](https://www.ibuttonlink.com/collections/thermochron?gclid=EAIaIQobChMIh6zQpZTO7QIVBKiGCh1X_wdzEAAYBCAAEgJAJfD_BwE/ "Temperature Logging iButtons") have been placed in the nests that record throughout the day. The researchers compared recorded temperatures of [painted turtles](https://en.wikipedia.org/wiki/Painted_turtle "Painted Turtle") from maternally selected nest sites with those from randomly selected nest sites. The goal is to process the raw temperature data from the nests to determine whether maternal nests have different incubation temperatures than random nests.

The given files that were used in the beginning are raw outputs from the temperature sensors. From 22 May to 17 June 2010, the researchers monitored the Thomson Causeway Recreation Area in Thomson, Illinois, USA. They excavated eggs from the top of a nest within approximately 12 h of oviposition, and placed eggs in containers filled with moist soil, and stored them in Styrofoam boxes. For each focal nest, they constructed two artificial nest chambers to identical dimensions to be the same depth as the original nest. Then, they placed each nest in either the ‘maternal’ treatment nearby the original nest location or the ‘random’ treatment randomly placed across the field site. The corresponding files are labeled with the nest number and either an f for maternal or and an r for random.

## Cleaning the Data and the Analysis

### Part A

For cleaning the data, I have written a bash script named ***JAHANGIRI_PartA.sh***

The given files (the metadata.csv file that I have begined with are not comprehensive of all the nests in the metadata file. Some nests were predated and the sensors were lost. To make sure each nest has a pair of files from both treatments, I have setup a loop to extract the paired log files for a given nest. This script will continue to work, when there is more data in metadata.csv (it is not hardcoded to the number of nests.) 

Within the loop, the raw data for each nest pair is extracted and written into a file which is imported into R. The temperature data for all the nests are combined into a single master tab-delimited file with five columns (some columns are added). Also, the date is converted into [Julian date](https://en.wikipedia.org/wiki/Julian_day/ "Julian day") format.
