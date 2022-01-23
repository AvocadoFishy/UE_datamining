setwd("G:/My Drive/ComputationalStuff/UrbanEcosystems/Git/RSQA_worksheet")
library('tidyverse', 'readr')
library('dplyr')



# Loading data into R -----------------------------------------------------
mydata <- read.csv('1.21.2022.CSQA_ConstituentGroups=Organics,Pesticides/Results.csv')
View(mydata)

# 12. show the frequency of parameter measurements done based on the PARM_NM column
exp_count <- mydata %>% 
  group_by(PARM_NM) %>% 
  summarise(count=n())

# create hist
param_count_hist <- ggplot(exp_count, aes(count)) +
  geom_histogram(binwidth=50) +
  labs(title='Distribution showing the number of a unique parameter\'s
  measurements [x] and respective frequency [y]', x='Measurements on a unique
  parameter') +
  theme_classic()
param_count_hist

# arrange exp_count to only contain >50 observations in desc order
exp_count <- exp_count[exp_count$count>50,]
exp_count <- exp_count[order(exp_count$count, decreasing=TRUE), ]
view(exp_count)



# Plotting one paramter ---------------------------------------------------
# pick parameter want to work w/ 
imidacloprid_data <- mydata[mydata$PARM_NM=='Imidacloprid, wf', ] # filter also could be used here
