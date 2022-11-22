#name: 'keyan liu'
#date:'21/11/2022'
#This is R script file for Data wrangling exercise in week 3

library(tidyverse)
# read the data into memory
math <- read_delim("student-mat.csv", 
                          delim = ";", escape_double = FALSE, trim_ws = TRUE)
por <- read_delim("student-por.csv", 
                          delim = ";", escape_double = FALSE, trim_ws = TRUE)
# Look at the dimensions of the data
dim(math)
dim(por)
# Look at the structure of the data
str(math)
str(por)

# access the dplyr package
library(dplyr)

# give the columns that vary in the two data sets
free_cols <- c("failures","paid","absences","G1","G2","G3")

# the rest of the columns are common identifiers used for joining the data sets
join_cols <- setdiff(colnames(por), free_cols)

# join the two data sets by the selected identifiers
math_por <- inner_join(math, por, by = join_cols)

# look at the column names of the joined data set
col(math_por)

# glimpse at the joined data set
glimpse(math_por)

# print out the column names of 'math_por'

colnames(math_por)
# create a new data frame with only the joined columns
alc <- select(math_por, all_of(join_cols))

# for every column name not used for joining...
for(col_name in free_cols) {
  # select two columns from 'math_por' with the same original name
  two_cols <- select(math_por, starts_with(col_name))
  # select the first column vector of those two columns
  first_col <- select(two_cols, 1)[[1]]
  
  # then, enter the if-else structure!
  # if that first column vector is numeric...
  if(is.numeric(first_col)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[col_name] <- round(rowMeans(two_cols))
  } else { # else (if the first column vector was not numeric)...
    # add the first column vector to the alc data frame
    alc[col_name] <- first_col
  }
}


# define a new column alc_use by combining weekday and weekend alcohol use
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)
# define a new logical column 'high_use'
alc <- mutate(alc, high_use = alc_use > 2)
# glimpse at the new combined data
glimpse(alc)

# set working directory
setwd("/Users/liukeyan/Desktop/open data science/IODS-project2/data")
#Save the analysis dataset to the ‘data’ folder
z <- write.csv(alc, file = "alc.csv")
# read data
learning2014_2 <- read_csv("alc.csv")

#check the data
str(alc)
head(alc)
