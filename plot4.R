library(doBy)
library(ggplot2)
library(gridExtra)

NEI <- readRDS("../../data/exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("../../data/exdata_data_NEI_data/Source_Classification_Code.rds")

# Subset out the EI.Sector that is Fuel Combustion of Coal
coal <- subset(SCC, select = c(SCC,EI.Sector), 
                    subset = (grepl("coal",x=EI.Sector , ignore.case=TRUE)))

# Add the EI.Sector to NEI data and skip any rows that are not Coal
NEIcoal <- merge(x=NEI, y=coal, by=c("SCC"),all=FALSE)
byYearCoal <- summaryBy(Emissions ~ year + EI.Sector, 
                             data = NEIcoal,
                             FUN=c(length,mean,median,sum,sd))

q <- ggplot(aes(x=log10(Emissions), colour=EI.Sector, group=EI.Sector), data=NEIcoal)
q <- q + geom_density(fill=NA)
q <- q + ggtitle("Distribution of Emissions for coal combustion")

p <- ggplot(data=byYearCoal, aes(x=year, y=log10(Emissions.sum), group=EI.Sector))
p <- p + geom_line(aes(colour = EI.Sector))
p <- p + ggtitle("Emissions by year for coal combustion")
p <- p + xlab("Year")
p <- p + ylab("PM2.5 Emission in Tons (log10)")
p

r <- arrangeGrob(q,p)

ggsave(r,file="plot4.png",scale=1.5)
