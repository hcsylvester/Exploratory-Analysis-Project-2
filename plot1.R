#Plot 1 - Check directory
getwd()
dir()

#Load packages needed for data
library(data.table)
library(dplyr)

#Store data into variables
NEI <- data.table::as.data.table(x = readRDS(file = "summarySCC_PM25.rds"))
SCC <- data.table::as.data.table(x = readRDS(file = "Source_Classification_Code.rds"))

#Create subset of data based on emissions and year
full_emissions <- NEI[, lapply(.SD, sum, na.rm = TRUE), .SDcols = c("Emissions"), by = NEI$year] 

#Created for labels on axis
year <- c(1999, 2002, 2005, 2008)
yaxis <- (NEI$Emissions)

#Create image of plot
png(filename = "plot1.png")

#Create plot
plot(full_emissions$NEI, full_emissions$Emissions, type = "l", xlab = "Year", ylab = "Emissions", main = "Emissions through 1999 - 2008", xaxt = "none")
axis(1, year, labels = paste(year))

dev.off()
