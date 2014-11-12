library("data.table")
library("plyr")
library("ggplot2")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.

NEI_baltimore <- NEI[which(NEI$fips == "24510"), ]
baltimore_emissions <- ddply(NEI_baltimore, .(type, year), summarize, Emissions = sum(Emissions))

png(filename='plot3.png', width=480, height=480, units='px')
#
qplot(year, Emissions, data = baltimore_emissions, group = baltimore_emissions$type, 
    color = baltimore_emissions$type, geom = c("point", "line"), ylab = expression("Total Emissions, tons PM"[2.5]), 
    xlab = "Year", main = "Total Emissions in Baltimore by Type of Pollutant") + scale_colour_discrete(name  ="Pollutant Type")
dev.off()

