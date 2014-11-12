setwd("~/eda/ExploratoryData/assignment2")
library("data.table")
library("plyr")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

total_emissions <- with(NEI, aggregate(Emissions, by = list(year), sum))
png(filename = "plot1.png", width = 480, height = 480, units = "px")
plot(total_emissions, type = "o", pch = 8, col = "brown", ylab = "Emissions (tons)", xlab = "Year", main = "Annual Emissions")
dev.off()

