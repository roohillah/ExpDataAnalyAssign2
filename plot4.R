library(plyr)
library(ggplot2)
library(data.table)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Convert into data.table
NEI.DT = data.table(NEI)
SCC.DT = data.table(SCC)

# Problem 4
coal_scc = SCC.DT[grep("Coal", SCC.Level.Three), SCC]
coal_emissions = NEI.DT[SCC %in% coal.scc, sum(Emissions), by = "year"]
setnames(coal_emissions, c("year","V1"), c("Year", "Emissions"))
# reduce label size by 1000
coal_emissions[["Emissions"]] = coal_emissions[["Emissions"]] / 1000
png(filename='plot4.png', width=480, height=480, units='px')
# Have emissions from coal combustion related sources decreased significantly from 1999-2008.
g = ggplot(coal_emissions, aes(Year, Emissions))
g + geom_point(color = "red")  + geom_line(color = "black")  + labs(title = "Emissions from Coal Combustion for the US") + labs(y = expression("Total Emissions, kilotons PM"[2.5]))
dev.off()