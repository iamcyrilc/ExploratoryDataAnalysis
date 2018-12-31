library("ggplot2")

#Exploratory Data Analysis assignment.
# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
# which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City? 

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

# Subset Baltimore data
baltimore_data <- subset(summary_pm25, fips == "24510")

#Aggregate emission based on year and type
total_emission_bt <- aggregate(Emissions ~ year+type, data = baltimore_data, sum)

png(file = "plot3.png")
#Plot emission by type by year
p <- ggplot(aes(x = year, y = Emissions, fill=type), data=total_emission_bt)
p+geom_bar(stat = "Identity")+facet_grid(.~type)+labs(x="year" , y = "PM25 Emission in tonnes", title="PM25 Emission in Baltimore by type.")+guides(fill=FALSE)

dev.off()



