# Need doBy library for summaryBy
library(doBy)

# PM2.5 Emissions Data (summarySCC_PM25.rds): 
# This file contains a data frame with all of the PM2.5 emissions data for 1999, 2002, 2005, and 2008. For each year,
#the table contains 
# number of tons of PM2.5 emitted from a specific type of source for the entire year.

NEI <- readRDS("../../data/exdata_data_NEI_data/summarySCC_PM25.rds")

# Source Classification Code Table (Source_Classification_Code.rds): 
# This table provides a mapping from the SCC digit strings in the Emissions table to the actual name of the PM2.5 #source. 
# The sources are categorized in a few different ways from more general to more specific and you may choose to explore #whatever 
# categories you think are most useful. For example, source “10100101” is known as “Ext Comb /Electric Gen /Anthracite
#Coal /Pulverized Coal”

SCC <- readRDS("../../data/exdata_data_NEI_data/Source_Classification_Code.rds")

# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, 
# make a plot showing the
# total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.
# 

# Simple Base graphics bar plot of Emmissions per year. NOT segmented by type or or fips
byYear <- summaryBy(Emissions ~ year, data = NEI, FUN=c(length,mean,median,sum,sd))
png("plot1.png")
barplot(height = byYear$Emissions.sum, 
      names= byYear$year,
      main = "Sum Total of all PM2.5 Emisions By year",
      sub = "There is a year over year reduction",
      ylab = "PM2.5 Emissions in Tons",
      xlab = "Year")
dev.off()
