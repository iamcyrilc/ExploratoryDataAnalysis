#Exploratory Data Analysis assignment.
# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (\color{red}{\verb|fips == "24510"|}fips=="24510") from 1999 to 2008? Use the base plotting system to make a plot answering this question.

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

#Aggregate emission based on year
total_emission_b <- aggregate(Emissions ~ year, data = baltimore_data, sum)

png(file = "plot2.png")
#Plot emission by year
barplot(total_emission_b$Emissions, names.arg = total_emission_b$year, xlab = "Year", ylab = "PM25 Emission (tonnes)", main = "PM 25 Emission in Baltimore City")
dev.off()


