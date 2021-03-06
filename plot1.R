library(doBy)

NEI <- readRDS("../../data/exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("../../data/exdata_data_NEI_data/Source_Classification_Code.rds")

# Summarize the data by year - include some basic metrics
byYear <- summaryBy(Emissions ~ year, data = NEI, FUN=c(length,mean,median,sum,sd))

#png("plot1.png")
windows(11,9,pointsize=1/100,bg="white")
par(mfrow = c(2, 1))

# Do a quick histogram to sanity check the data
hist(x = log10(NEI$Emissions),
     xlab = "Emissions",
     main = "Distribution of all Emissions data")


# Create the final plot for comparison
barplot(height = byYear$Emissions.sum, 
      names= byYear$year,
      main = "Sum Total of all PM2.5 Emisions By year",
      sub = "There is a year over year reduction",
      ylab = "PM2.5 Emissions in Tons",
      xlab = "Year")
savePlot('plot1.png',type="png")