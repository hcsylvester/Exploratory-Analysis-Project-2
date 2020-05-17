#Plot 5
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

#Create subset of data by on-road and zip code
Vehicle <- ddply(NEI[NEI$type == "ON-ROAD" & NEI$fips == "24510", ], 
                 .(type,year), summarize, TotalEmissions = sum(Emissions))

#Create image of plot
png(filename = "plot5.png")

#Create plot 
ggplot(Vehicle, aes(x = year, TotalEmissions)) + geom_bar(stat = "identity") +
        xlab("Year") + ylab("Total Emissions") +
        ggtitle("Motor Vehicle Emissions in Baltimore: 1999-2008") 

dev.off()
