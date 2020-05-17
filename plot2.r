#Plot 2
#Load packages needed for data
library(data.table)
library(dplyr)

#Store data into variables
NEI <- data.table::as.data.table(x = readRDS(file = "summarySCC_PM25.rds"))
SCC <- data.table::as.data.table(x = readRDS(file = "Source_Classification_Code.rds"))

#Create subset of data based on Baltimore emissions
balt_emissions <- NEI[fips == "24510", lapply(.SD, sum, na.rm = T), .SDcols = c("Emissions"), by = year]

#Create image of plot
png(filename = "plot2.png")

#Create plot 
plot(balt_emissions$Emissions ~ balt_emissions$year, type = "l", xlab = "Year", ylab = "Total Emissions", main = "Baltimore Emissions: 1999 - 2008")

dev.off()

