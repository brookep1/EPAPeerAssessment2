library(doBy)
library(ggplot2)

NEI <- readRDS("../../data/exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("../../data/exdata_data_NEI_data/Source_Classification_Code.rds")

# Subset out the EI.Sector that are Vehicles
vehicles <- subset(SCC, select = c(SCC,EI.Sector), 
                    subset = (grepl("vehicle",x=EI.Sector , ignore.case=TRUE)))

# Add the EI.Sector to NEI data and skip any rows that are not Vehicles
NEIVeh <- merge(x=NEI, y=vehicles, by=c("SCC"),all=FALSE)

# Create a quick little data frame that maps the fips to the locale name
M = as.data.frame(matrix(  
     c("Balt","24510","LA","06037"),
     nrow=2,           
     ncol=2,         
     byrow = TRUE))
names(M) <- c("location","fips")

# Add the locale to NEI data and skip any rows that are not matched
NEIloc <- merge(x=NEIVeh, y=M, by=c("fips"),all=FALSE)

# Subset that to by year and locale
byYearFips <- summaryBy(Emissions ~ year + location, 
                        data = NEIloc,
                        FUN=c(length,mean,median,sum,sd))

p <- ggplot(data=byYearFips, aes(x=year, y=log10(Emissions.sum), group=location))
p <- p + geom_line(aes(colour = location))
p <- p + ggtitle("Emissions by year for Baltimore City, MD and LA")
p <- p + xlab("Year")
p <- p + ylab("PM2.5 Emission in Tons (log10)")
p
ggsave(p,file="plot6.png",scale=1.5)