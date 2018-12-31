library("ggplot2")

#Exploratory Data Analysis assignment.
# How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?

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

#Aggregate emission based on year
total_emission_veh_bal <-  aggregate(Emissions ~ year, data= summary_emission_veh_Bal,sum)

png(file = "plot5.png")
#Plot emission by year in US
p <- ggplot(aes(x = year, y = Emissions/1000), data=total_emission_veh_bal)
p+geom_bar(stat = "Identity")+labs(x="year" , y = "PM25 Emission in (1000) tonnes", title="PM25 Vehicle Emission in Baltimore ")+guides(fill=FALSE)


dev.off()