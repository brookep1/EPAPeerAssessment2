library(doBy)

NEI <- readRDS("../../data/exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("../../data/exdata_data_NEI_data/Source_Classification_Code.rds")

# Summarize the data by year for Baltimore
byYearBalt <- summaryBy(Emissions ~ year, 
                             data = with(NEI,NEI[fips == "24510",]),
                             FUN=c(length,mean,median,sum,sd))

#png("plot2.png")
windows(11,9,pointsize=1/100,bg="white")
par(mfrow = c(2, 1))

# Do a quick histogram to sanity check the data
hist(x = log10(NEI[NEI$fips == "24510","Emissions"]),
     xlab = "Emissions",
     main = "Distribution of all Baltimore Emissions data")


# Create the final plot for comparison
barplot(height = byYearBalt$Emissions.sum, 
     names= byYearBalt$year,
     main = "Sum Total of all PM2.5 Emisions By year for Baltimore City",
     sub = "There appears to be a downwared trend over that period",
     ylab = "PM2.5 Emissions in Tons",
     xlab = "Year")
savePlot('plot2.png',type="png")
