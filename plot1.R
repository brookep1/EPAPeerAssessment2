library(doBy)

NEI <- readRDS("../../data/exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("../../data/exdata_data_NEI_data/Source_Classification_Code.rds")

# Summarize the data by year
byYear <- summaryBy(Emissions ~ year, data = NEI, FUN=c(length,mean,median,sum,sd))

png("plot1.png")
barplot(height = byYear$Emissions.sum, 
      names= byYear$year,
      main = "Sum Total of all PM2.5 Emisions By year",
      sub = "There is a year over year reduction",
      ylab = "PM2.5 Emissions in Tons",
      xlab = "Year")
dev.off()
