#Plot 6
#Load packages needed for data
library(data.table)
library(dplyr)
library(ggplot2)
library(plyr)

#Store data into variables
NEI <- data.table::as.data.table(x = readRDS(file = "summarySCC_PM25.rds"))
SCC <- data.table::as.data.table(x = readRDS(file = "Source_Classification_Code.rds"))

#Read in this way because $ will not accept atomic vectors if read as data.table
SCC <- readRDS(file = "Source_Classification_Code.rds")

#Create subset of Baltimore emissions on road only 
Vehicle_balt <- ddply(NEI[NEI$type == "ON-ROAD" & NEI$fips == "24510", ], 
                 .(type,year), summarize, TotalEmissions = sum(Emissions))

#Create subset of LA emissions on road only 
Vehicle_cal <- ddply(NEI[NEI$type == "ON-ROAD" & NEI$fips == "06037", ], 
                      .(type,year), summarize, TotalEmissions = sum(Emissions))

#Create image of plot, note res must equal 45 or else will not show on image
png(filename = "plot6.png", width = 480, height = 480, res = 45)

#Create parameters for two graphs to compare
par(mfrow = c(1, 2), oma = c(0,0,2,0))

#Create first plot of Baltimore
plot(Vehicle_balt$TotalEmissions ~ Vehicle_balt$year, type = "l", xlab = "Year", 
     ylab = "Total Emissions", main = "Baltimore MV Emissions: 1999 - 2008", lwd = 4)

#Create second plot of LA
plot(Vehicle_cal$TotalEmissions1 ~ Vehicle_cal$year, type = "l", xlab = "Year", 
     ylab = "Total Emissions", main = "Los Angeles County MV Emissions: 1999 - 2008", lwd = 4)

#Create title 
mtext(side = 3, "Motor Vehicle Source Emissions in Baltimore and Los Angeles County: 1999 - 2008", 
      outer = T, cex = 1.5)

dev.off()
