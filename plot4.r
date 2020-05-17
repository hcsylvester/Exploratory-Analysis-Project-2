#Plot 4
#Load packages needed for data
library(data.table)
library(dplyr)
library(ggplot2)

#Store data into variables
NEI <- data.table::as.data.table(x = readRDS(file = "summarySCC_PM25.rds"))
SCC <- data.table::as.data.table(x = readRDS(file = "Source_Classification_Code.rds"))

#Read in this way because $ will not accept atomic vectors if read as data.table
SCC <- readRDS(file = "Source_Classification_Code.rds")

#Subset data pertaining to combustion and coal in SCC data
coal_comb <- SCC[grep("Comb.*Coal", SCC$Short.Name), "SCC"]

#Futher subset data using SCC and NEI data
coal_NEI <- NEI[NEI$SCC %in% coal_comb, ]

#Complete subset of data pertaining to combustion and coal based on both SCC and NEI
coal_complete <- coal_NEI %>% group_by(year) %>% summarize(TotalEmissions = sum(Emissions))

#Create image of plot
png(filename = "plot4.png")

#Create plot
ggplot(coal_complete, aes(year, TotalEmissions, fill = year)) + geom_bar(stat = "identity") +
        xlab("Year") + ylab("Total Emissions") + 
        ggtitle("Coal Combustion Related Emissions Across US")

dev.off()


