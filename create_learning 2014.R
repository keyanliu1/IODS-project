#name: 'keyan liu'
#date:'13/11/2022'
#This is R script file for Data wrangling exercise in week 2

library(tidyverse)
# read the data into memory
lrn14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)

# Look at the dimensions of the data
dim(lrn14)

# Look at the structure of the data
str(lrn14)
#there are 183 observations of 60 variables in the data frame

#Create an analysis dataset with the variables gender, age, attitude, deep, stra, surf and points by combining questions in the learning2014 data, 
#access the library
library(dplyr)
#Scale combination variables to the original scales

lrn14$attitude <- lrn14$Attitude / 10
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
lrn14$deep <- rowMeans(lrn14[, deep_questions])
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
lrn14$surf <- rowMeans(lrn14[, surface_questions])
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")
lrn14$stra <- rowMeans(lrn14[, strategic_questions])
# choose a handful of columns to keep
keep_columns <- c("gender","Age","attitude", "deep", "stra", "surf", "Points")

# select the 'keep_columns' to create a new dataset
learning2014 <- select(lrn14, one_of(keep_columns))

# see the structure of the new dataset
str(learning2014)

# print out the column names of the data
colnames(learning2014)

# change the name of the second column
colnames(learning2014)[2] <- "age"

# change the name of "Points" to "points"
colnames(learning2014)[7] <- "points"

# print out the new column names of the data
colnames(learning2014)
# Exclude observations where the exam points variable is zero
learning2014 <- filter(learning2014, points > "0")
# set working directory
setwd("/Users/liukeyan/Desktop/open data science/IODS-project2/data")
#Save the analysis dataset to the ‘data’ folder
z <- write.csv(learning2014, file = "learning2014.csv")
# read data
learning2014_2 <- read_csv("learning2014.csv")

#check the data
str(learning2014_2)
head(learning2014_2)
