library(plyr)
library(ggplot2)
library(data.table)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Convert into data.table
NEI.DT = data.table(NEI)
SCC.DT = data.table(SCC)

# Problem 6 : Compare emissions in Baltimore to Los Angeles CountY (FIPS == 06037).
# Which city has seen greater changes in time?
mv_scc = SCC.DT[grep("[mM]obile|[vV]ehicles", EI.Sector), SCC]
mv_emissions = NEI.DT[SCC %in% mv_scc, sum(Emissions), by=c("year","fips")]
setnames(mv_emissions, c("year","fips","V1"), c("Year", "FIPS", "Emissions"))

png(filename = "plot6.png", width = 480, height = 480, units = "px")
g = ggplot(mv_emissions[FIPS=="24510" | FIPS=="06037"], aes(Year,  (Emissions)))
g + geom_point() + geom_line(aes(color=FIPS)) + scale_color_discrete(name = "County", 
    breaks = c("06037", "24510"), labels = c("Los Angeles", "Baltimore")) + 
    labs(y = expression("Total Emissions, tons PM"[2.5])) + labs(title = "Annual Motor Vehicle Emissions")

dev.off()

png(filename = "plot6_log.png", width = 480, height = 480, units = "px")
#
# Since the magnitudes are different, we coudl use the log function to amplify the results
# 
g = ggplot(mv_emissions[FIPS=="24510" | FIPS=="06037"], aes(Year,  log(Emissions)))
g + geom_point() + geom_line(aes(color=FIPS)) + scale_color_discrete(name = "County", 
    breaks = c("06037", "24510"), labels = c("Los Angeles", "Baltimore")) + 
    labs(y = expression("log(Total Emissions), PM"[2.5])) + labs(title = "Annual Motor Vehicle Emissions")

dev.off()