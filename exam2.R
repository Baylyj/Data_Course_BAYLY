rm(list = ls())
setwd("~/Desktop/Data_Course_BAYLY/")
# Load the libraries that you use here:

library(tidyr)
library(ggplot2)
library(fitdistrplus)

############# Part 1 - Preparing wide data ################## ---------------- (30 points possible)

# read in salaries.csv
# This is faculty salary information from 1995 - Split up by university, state, faculty rank, and university tier

salaries = read.csv("~/Desktop/GIT_REPOSITORIES/Data_Course/exam2/salaries.csv")

# convert to usable format so we can look at salaries as a dependent variable (10 points)

df = gather(salaries, key = "Title", value = "Salary", c(AssistProf,AssocProf,FullProf))

# create boxplot of salary by University Tier, colored by Faculty Rank (10 points)
# x-axis = Tier
# y-axis = Salary
# Boxplot fill color = Rank
# Title = "Faculty Salaries - 1995"
# export this boxplot to a file in your personal repository named "LASTNAME_exam2_plot1.jpeg" (10 points)

jpeg("~/Desktop/Data_Course_BAYLY/BAYLY_exam2_plot1.jpeg")
ggplot(df, mapping = aes(x=Tier, y=Salary, fill = Title), title = "Faculty Salaries - 1995") +
  geom_boxplot()+
  ggtitle("Faculty Salaries - 1995")
dev.off()


################# PART 2 ################### ------------ (70 points possible)

# read in atmosphere.csv
# this data frame has microbial diversity values over time found in atmospheric observation station air filters
# sampling date and two environmental variables [CO2] and [Aerosols] are reported for each measurement
# "Diversity" is the dependent variable

atmosphere = read.csv("~/Desktop/GIT_REPOSITORIES/Data_Course/exam2/atmosphere.csv")

# First, check whether your response variable is normally distributed (5 points)

fitdist(atmosphere$Diversity, "norm")

# Next, convert "Year" to a factor...just because (5 points)

atmosphere$Year = as.factor(atmosphere$Year)

# Create a simple ANOVA model with "Year" as the only explanatory variable (5 points)

mod1 = aov(Diversity ~ factor(Year), data = atmosphere)

# Now, create an ANOVA model that incorporates "Year", "Aerosol_Density", and their interaction (5 points)

mod2 = aov(Diversity ~ factor(Year):Aerosol_Density, data = atmosphere)


# Compare the two models mean-squared difference method to see which is better at making predictions 
# (20 points)

pred1 = add_predictions(atmosphere, model = mod1)
pred2 = add_predictions(atmosphere, model = mod2)

sqrt(mean((pred1$pred - atmosphere$Diversity)^2))
sqrt(mean((pred2$pred - atmosphere$Diversity)^2))


summary = summary(mod2)
# Export the summary ANOVA table of the better model to a text file in your repository named:
# "LASTNAME_exam2_table1.txt" (10 points)

sink("~/Desktop/Data_Course_BAYLY/BAYLY_exam2_table1.txt")
print(summary)
sink()

# use this model to predict what diversity should be for the following hypothetical conditions:
# note: only include the conditions that are part of your chosen model! (10 points)

# Year = 2007
# Quarter = "Q4"
# Month = August
# Mday = 10
# BarcodeSequence = "CTCTCTATCAGTGAGT"
# Aerosol_Density = 1000,
# CO2_Concentration = 384

newsample = data.frame()
newsample [1,1] = 2007
newsample [1,2] = 1000
names(newsample) <- c("Year","Aerosol_Density")

predict(mod2, newdata = newsample, interval = "confidence")


# Now, make a pretty plot to the following specifications:
# x-axis = Day
# y-axis = Aerosol_Density
# point transparency based on values of "Diversity"
# Title: "Decadal Aerosol Density"
# Subtitle: "More aerosols contribute to greater microbial diversity in the atmosphere"
# Save this plot in your repository as "LASTNAME_exam2_plot2.jpeg" (10 points)

jpeg("~/Desktop/Data_Course_BAYLY/BAYLY_exam2_plot2.jpeg")
ggplot(atmosphere, aes(x = Day, y = Aerosol_Density))+
  geom_point(aes(alpha = Diversity))
  ggtitle("Decadal Aerosol Density")+
  labs(subtitle = "More aerosols contribute to greater microbial diversity in the atmosphere")
dev.off()

#### When you are all finished, push the files, including this R script, onto your GitHub repo
#### I will look at your script and look for the three properly named files that you generated


