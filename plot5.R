library(doBy)
library(ggplot2)
library(gridExtra)

NEI <- readRDS("../../data/exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("../../data/exdata_data_NEI_data/Source_Classification_Code.rds")

# Subset out the EI.Sector that are Vehicles
vehicles <- subset(SCC, select = c(SCC,EI.Sector), 
                    subset = (grepl("vehicle",x=EI.Sector , ignore.case=TRUE)))

# Add the EI.Sector to NEI data and skip any rows that are not Vehicles
NEIVeh <- merge(x=NEI, y=vehicles, by=c("SCC"),all=FALSE)

# Subset that to Baltimore and summarize by year and EI.Sector
byYearVehBalt <- summaryBy(Emissions ~ year + EI.Sector, 
                        data = with(NEIVeh,NEIVeh[fips == "24510",]),
                        FUN=c(length,mean,median,sum,sd))


q <- ggplot(aes(y=log10(Emissions), x=EI.Sector, colour=EI.Sector), data=with(NEIVeh,NEIVeh[fips == "24510",]))
q <- q + geom_boxplot()
q <- q + scale_x_discrete(breaks=NULL)
q <- q + ggtitle("Boxplots of Vehicle Emissions for Baltimore")

p <- ggplot(data=byYearVehBalt, aes(x=year, y=log10(Emissions.sum), group=EI.Sector))
p <- p + geom_line(aes(colour = EI.Sector))
p <- p + ggtitle("Emissions by year for Vehicle types in Baltimore City")
p <- p + xlab("Year")
p <- p + ylab("PM2.5 Emission in Tons (log10)")
p

r <- arrangeGrob(q,p)

ggsave(r,file="plot5.png",scale=1.5)