#Plot 3
#Load packages needed for data
library(data.table)
library(dplyr)
library(ggplot2)

#Store data into variables
NEI <- data.table::as.data.table(x = readRDS(file = "summarySCC_PM25.rds"))
SCC <- data.table::as.data.table(x = readRDS(file = "Source_Classification_Code.rds"))

#Create subset of date using area code to narrow
balt <- NEI[fips == "24510",]

#Create image of plot
png(filename = "plot3.png")

#Create plot
ggplot(balt, aes(x = factor(year), Emissions, fill = type)) + 
        geom_bar(stat = "identity") + facet_grid(.~type) +
        xlab("Year") + ylab("Total Emissions") +
        ggtitle("Baltimore Emissions by Type")

dev.off()
