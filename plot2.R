library("data.table")
library("plyr")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Have total emissions from PM2.5 decreased in Baltimore from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission from Baltimore for each of the years 1999, 2002, 2005, and 2008.

NEI_baltimore <- NEI[which(NEI$fips == "24510"), ]
baltimore_emissions <- with(NEI_baltimore, aggregate(Emissions, by = list(year), sum))
png(filename = "plot2.png", width = 480, height = 480, units = "px")
plot(baltimore_emissions, type = "o", pch = 8, col = "brown", ylab = "Emissions (tons)", xlab = "Year", main = "Baltimore's Annual Emissions")
dev.off()

