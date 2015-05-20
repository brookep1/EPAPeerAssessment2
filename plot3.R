# Need doBy library for summaryBy
library(doBy)

# PM2.5 Emissions Data (summarySCC_PM25.rds): 
# This file contains a data frame with all of the PM2.5 emissions data for 1999, 2002, 2005, and 2008. For each year, the table contains 
# number of tons of PM2.5 emitted from a specific type of source for the entire year.

NEI <- readRDS("../../data/exdata_data_NEI_data/summarySCC_PM25.rds")

# Source Classification Code Table (Source_Classification_Code.rds): 
# This table provides a mapping from the SCC digit strings in the Emissions table to the actual name of the PM2.5 source. 
# The sources are categorized in a few different ways from more general to more specific and you may choose to explore whatever 
# categories you think are most useful. For example, source “10100101” is known as “Ext Comb /Electric Gen /Anthracite Coal /Pulverized Coal”

SCC <- readRDS("../../data/exdata_data_NEI_data/Source_Classification_Code.rds")

# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? Use the base plotting system to make a plot answering this question.
#
# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four #sources have seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen increases in emissions #from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.
# 
# Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

# Simple Base graphics bar plot of Emmissions per year
byYearTypeBalt <- summaryBy(Emissions ~ year + type, 
                             data = with(NEI,NEI[fips == "24510",]),
                             FUN=c(length,mean,median,sum,sd))

# 
# How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
# 
# Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions?
