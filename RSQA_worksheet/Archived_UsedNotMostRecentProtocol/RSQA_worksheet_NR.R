setwd("G:/My Drive/ComputationalStuff/UrbanEcosystems/Git/RSQA_worksheet")
library(tidyverse)
library(readr)
library(dplyr)


# CSQA All Data 1.22.2022 -------------------------------------------------
mydata <- read.csv('G:/My Drive/ComputationalStuff/UrbanEcosystems/Git/RSQA_worksheet/CSQA_all_data_1.21.2022/Results.csv')
View(mydata)

exp_count <- mydata %>% 
  group_by(PARM_NM) %>% 
  summarise(count=n())

# 12. create hist of exp_count showing frequency of 'counts'
# this will allow use to see the frequency of datapoints of each paramater measurement
uinque_measurements_hist <- ggplot(exp_count, aes(count)) +
  geom_histogram(binwidth=100) +
  labs(title='Frequency [y] of total data points by unique parameters [x]',
    x='measurements done on a unique parameter') +
  theme_classic()

# how many counted once; other notation: count==1?
exp_count_counted_once <- length(exp_count$PARM_NM[exp_count$count==1])

# observe exp_count$count 
exp_count <- exp_count[order(exp_count$count, decreasing=TRUE), ]
head(exp_count)
