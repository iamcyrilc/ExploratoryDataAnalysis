library("ggplot2")

#Exploratory Data Analysis assignment.
# Compare emissions from motor vehicle sources in Baltimore City with emissions 
# from motor vehicle sources in Los Angeles County, California fips=="06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?

#Download file if not exist

#Here, it is assumed that both rds files are missing
if(!file.exists("Source_Classification_Code.rds") && !file.exists("summarySCC_PM25.rds"))
{
        data_file = "NEI_data.zip"
        if(!file.exists(data_file))  
        {
                download.file(url="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = data_file)
        }
        
        unzip(data_file)
}

#read data file
class_code <- readRDS("Source_Classification_Code.rds")
summary_pm25 <- readRDS ("summarySCC_PM25.rds")

#Get class codes for all sector that contains vehicle 
scc_codes_veh <- class_code$SCC[grepl("[V|v]ehicle",class_code$EI.Sector)]

# Filter all emission records where codes in scc_codes in Baltimore
summary_emission_veh_Bal <- subset(summary_pm25, SCC %in% scc_codes_veh  & fips == "24510")
summary_emission_veh_Bal$city = "Baltomore"

#Los Angeles
summary_emission_veh_la <- subset(summary_pm25, SCC %in% scc_codes_veh  & fips == "06037")

#Aggregate emission based on year
total_emission_veh_bal <-  aggregate(Emissions ~ year, data= summary_emission_veh_Bal,sum)
summary_emission_veh_la$city = "Los Angeles"

# Cobine data
combined_emission <- rbind(summary_emission_veh_Bal,summary_emission_veh_la)

png(file = "plot6.png")
#Plot emission by year in US
p <- ggplot(aes(x = year, y = Emissions/1000, fill = city), data=combined_emission)
p+geom_bar(stat = "Identity") +facet_grid(.~city) +labs(x="year" , y = "PM25 Emission in (1000) tonnes", title="PM25 Vehicle Emission in Baltimore & LA ")+guides(fill=FALSE)


dev.off()