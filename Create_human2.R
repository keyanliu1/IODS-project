#name: 'keyan liu'
#date:'05/12/2022'
#This is R script file for Data wrangling exercise in week 5

library(tidyverse)
# read the data into memory
# read the human data
human <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/human1.txt", 
                    sep =",", header = T)
#The 'human' dataset originates from the United Nations Development Programme
#Most of the variable names have been shortened and two new variables have been computed

d# look at the (column) names of human
names(human)

# look at the structure of human
str(human)

# print out summaries of the variables
summary(human)
# transform the Gross National Income (GNI) variable to numeric
human$GNI <- gsub(",", "", human$GNI) %>% as.numeric
library(dplyr)
# columns to keep
keep <- c("Country", "Edu2.FM", "Labo.FM", "Life.Exp", "Edu.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")

# select the 'keep' columns
human <- select(human, one_of(keep))
# print out a completeness indicator of the 'human' data
complete.cases(human)

# print out the data along with a completeness indicator as the last column
data.frame(human[-1], comp = complete.cases(human))

# filter out all rows with NA values
human <- filter(human, complete.cases(human)) # modify the "TRUE", see instructions above!
human
rownames(human) <- human$Country
last <- nrow(human) - 7
# save the data
human <- write.csv(human, file = "human.csv")
