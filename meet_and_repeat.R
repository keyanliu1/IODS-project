library(dplyr); library(tidyr)
#read the BPRS data
BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep  =" ", header = T)
RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", header = TRUE, sep = '\t')
# Look at the (column) names of 
names(BPRS)
names(RATS)
# Look at the structure 
str(BPRS)
str(RATS)
# Print out summaries of the variables
summary(BPRS)
summary(RATS)
#factor the data
BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)
RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)
#Convert the data sets to long form and add variables
BPRSL <-  pivot_longer(BPRS, cols=-c(treatment,subject),names_to = "weeks",values_to = "bprs") %>% arrange(weeks)
BPRSL <-  BPRSL %>% mutate(week = as.integer(substr(weeks,5,5)))
RATSL <- pivot_longer(RATS, cols=-c(ID,Group), names_to = "WD",values_to = "Weight")  %>%  mutate(Time = as.integer(substr(WD,3,4))) %>% arrange(Time)
# look at the names, structure and summary of the long form data
names(BPRSL)
names(RATSL)
str(BPRSL)
str(RATSL)
summary(BPRSL)
summary(RATSL)