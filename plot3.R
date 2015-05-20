library(doBy)
library(ggplot2)

NEI <- readRDS("../../data/exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("../../data/exdata_data_NEI_data/Source_Classification_Code.rds")

# Summaryize the data by year and type for Baltimore only
byYearTypeBalt <- summaryBy(Emissions ~ year + type, 
                             data = with(NEI,NEI[fips == "24510",]),
                             FUN=c(length,mean,median,sum,sd))

p <- ggplot(data=byYearTypeBalt, aes(x=year, y=Emissions.sum, group=type))
p <- p + geom_line(aes(colour = type))
p <- p + ggtitle("Emissions by year and type for Baltimore City")
p <- p + xlab("Year")
p <- p + ylab("PM2.5 Emission in Tons")
p
ggsave(p,file="plot3.png",scale=1.5)
