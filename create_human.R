#name: 'keyan liu'
#date:'28/11/2022'
#This is R script file for Data wrangling exercise in week 4

library(tidyverse)
# read the data into memory
lhd <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/human_development.csv")
gii <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/gender_inequality.csv", na = "..")

# Look at the dimensions of the data
dim(lhd)
dim(gii)
# Look at the structure of the data
str(lhd)
str(gii)
summary(lhd)
summary(gii)
#Rename some variables
#access the library
library(dplyr)

lhd$GNI <- lhd$`Gross National Income (GNI) per Capita`
lhd$Life.exp <- lhd$`Life Expectancy at Birth`
lhd$Edu.Exp <- lhd$`Expected Years of Education`
lhd$HDI <- lhd$`Human Development Index (HDI)`
lhd$Edu.mean <- lhd$`Mean Years of Education`
lhd$GNI_HDI <- lhd$`GNI per Capita Rank Minus HDI Rank` 
lhd<- lhd[,-(3:8)]  
gii$Parli.F= gii$`Percent Representation in Parliament`
gii$Edu2.F <- gii$`Population with Secondary Education (Female)`
gii$Mat.Mor <- gii$`Maternal Mortality Ratio`
gii$Ado.Birth <- gii$`Adolescent Birth Rate`
gii$Edu2.M<- gii$`Population with Secondary Education (Male)`
gii$GII <-gii$`Gender Inequality Index (GII)`
gii$Labo.F <- gii$`Labour Force Participation Rate (Female)`
gii$Labo.M <- gii$`Labour Force Participation Rate (Male)`
gii<- gii[,-(3:10)] 

#add new variables
gii <- mutate(gii, Edu2.FM = Edu2.F / Edu2.M)
gii <- mutate(gii, Labo2.FM = Labo.F / Labo.M)

#join the dataset together
human <- inner_join(lhd, gii, by = "Country")
human <- write.csv(human, file = "human.csv")
