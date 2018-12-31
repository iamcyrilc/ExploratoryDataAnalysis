#Exploratory Data Analysis assignment.
# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission from 
# all sources for each of the years 1999, 2002, 2005, and 2008.

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

#Aggregate emission based on year
total_emission <-  aggregate(Emissions ~ year, data= summary_pm25,mean)

png(file = "plot1.png")
#Plot emission by year
barplot(total_emission$Emissions, names.arg = total_emission$year, xlab = "Year", ylab = "PM 25 Emissions (tonnes)", main = "PM 25 Emissions from all US sources.")

dev.off()
