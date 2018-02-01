########################HOUSEKEEPING##################
setwd("~/R/Data_Course_Material/Data_Course/Exam_1/")
df = read.csv("DNA_Conc_by_Extraction_Date.csv.gz")
library(dplyr)
df$Extract.Code = NULL

#########################Generate and Write Tables#########################

jpeg("~/R/Data_Course/Data_Course_BAYLY/Exam1/DNA_Concentration_Katy.jpeg")
hist(df$DNA_Concentration_Katy, main = "DNA Concentration Katy", xlab = "Concentration After PCR")
dev.off()

jpeg("~/R/Data_Course/Data_Course_BAYLY/Exam1/DNA_Concentration_Ben.jpeg")
hist(df$DNA_Concentration_Ben, main = "DNA Concentration Ben", xlab = "Concentration After PCR")
dev.off()

jpeg("~/R/Data_Course/Data_Course_BAYLY/Exam1/BAYLY_Plot1.jpeg")
plot(as.factor(df$Year_Collected), df$DNA_Concentration_Katy, main = "Katy's Extractions", ylab = "DNA Concentration", xlab = "YEAR")
dev.off()

jpeg("~/R/Data_Course/Data_Course_BAYLY/Exam1/BAYLY_Plot2.jpeg")
plot(as.factor(df$Year_Collected), df$DNA_Concentration_Ben, main = "Ben's Extractions", ylab = "DNA Concentration", xlab = "YEAR")
dev.off()

##################Calculate Ben's Worst Year###################################

years = unique(df$Year_Collected) #Create an array of all the possible years

x = 1
Average_val_Katy = c()
for (i in years) #Create an array that displays the average concentration values of each year
{
 Average_val_Katy [x] = mean(df$DNA_Concentration_Katy[which(df$Year_Collected == years[x])])
  x = x+1
}

x = 1
Average_val_Ben = c()
for (i in years) #Same for Ben
{
  Average_val_Ben [x] = mean(df$DNA_Concentration_Ben[which(df$Year_Collected == years[x])])
  x = x+1
}

years[which.min(Average_val_Ben/Average_val_Katy)] #Display the year where Ben's average was closest to Katy's

rm(list = "i",x,Average_val_Katy)

####################Average Concentrations By Year################

# We can use our data frames from earlier!
Ben_By_Year = matrix(nrow = 12, ncol = 2)
Ben_By_Year[,1] = years
Ben_By_Year[,2] = Average_val_Ben
colnames(Ben_By_Year) <- c("Year","Ben_Average_Conc")

Ben_By_Year[which.max(Ben_By_Year[,2]),] # Show the year and Concentration of the best year
write.csv(Ben_By_Year, file = "~/R/Data_Course/Data_Course_BAYLY/Exam1/Ben_average_by_year.csv")



