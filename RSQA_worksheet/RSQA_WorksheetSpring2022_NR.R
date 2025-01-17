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

# make scatter plot RESULT_VA~PARM_NM [note: this is suppose to be wrong]
results_parm_scat <- ggplot(imidacloprid_data, aes(PARM_NM, RESULT_VA)) +
  geom_point()
results_parm_scat # use geom_jitter() since they're ontop of each other
# will be doing jitterplot instead since clustered
results_parm_jit <- ggplot(imidacloprid_data, aes(PARM_NM, RESULT_VA)) +
  geom_jitter() +
  theme_classic() +
  theme(axis.text=element_blank()) +
  labs(title='CSQA Measurement of Imidacloprid',
       x='Imidacloprid', y='Concentration Detected [ng/l]')
  
results_parm_jit



# Plotting multiple parameters --------------------------------------------
# select the top five parameters from mydata
top_5_data <- mydata[mydata$PARM_NM %in% exp_count$PARM_NM[1:5], ]
top_5_jitterplot <- ggplot(top_5_data, aes(PARM_NM, RESULT_VA)) +
  geom_jitter(aes(color=PARM_NM)) +
  theme_classic() +
  theme(axis.text.x=element_blank()) +
  labs(title='CSQA Measurement of Various Chemicals',
       x='Chemical', y='Concentration Detected [ng/l]')
top_5_jitterplot

# instead, create a facet plot
top_5_facet <- ggplot(top_5_data, aes(PARM_NM, RESULT_VA)) +
  geom_jitter(aes(color=PARM_NM), alpha=0.35) +
  facet_wrap(.~PARM_NM, scales='free') +
  theme_classic() + theme(axis.text.x=element_blank(),
                          strip.text.x=element_blank(),
                          axis.title.x=element_blank()) +
  labs(col='Chemical', y='Concentration', title='CSQA Chemical Concentration in Stream Samples') +
  scale_color_hue(labels=c('AMPA [ug/l]', 'Glufosinate [ug/l]', 'Glyphosate [ug/l]', 'Imidacloprid [ng/l]', 'Myclobutanil [ng/l]'))

top_5_facet

