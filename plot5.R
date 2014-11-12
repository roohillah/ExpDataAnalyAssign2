library(plyr)
library(ggplot2)
library(data.table)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Convert into data.table
NEI.DT = data.table(NEI)
SCC.DT = data.table(SCC)

# Problem 5 : Have emissions from motor vehicle sources in Baltimore decreased from 1999-2008, even though there was a blip in the year 2008?
mv_scc = SCC.DT[grep("[mM]obile|[vV]ehicles", EI.Sector), SCC]
mv_emissions_baltimore = NEI.DT[SCC %in% mv_scc, sum(Emissions), by=c("year","fips")][fips == "24510"]
setnames(mv_emissions_baltimore, c("year","fips","V1"), c("Year", "FIPS", "Emissions"))

png(filename='plot5.png', width=480, height=480, units='px')
g = ggplot(mv_emissions_baltimore, aes(Year, Emissions))
g + geom_point(color = "red") + geom_line(color = "black") + labs(y = expression("Total Emissions, PM"[2.5])) + labs(title = "Total Emissions from Motor Vehicle Sources in Baltimore")
dev.off()
