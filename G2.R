#install packages
install.packages("dplyr")
install.packages('tidyr')


#Load the libraries
library(tidyr)
library(dplyr) 

  
#importing dataset
data<-read.csv("G2_anthropometry.csv" , na.strings = c(''))
head(data,25)
tail(data,10)
str(data)


#explore data
summary(data)


#remove text
data$height<-gsub('cm','',data$height)
data


#remove text 
data$gender<-gsub('cm','M',data$gender)
data
str(data)
summary(data)

#convert data$height data type from chr to num 
data$height<-as.numeric(data$height)
data$foot_length<-as.numeric(data$foot_length)
str(data)

 

#Get all rows contain missing data
!complete.cases(data)
data[!complete.cases(data),]
data[!is.na(data$foot_length),]
data<-data[!is.na(data$foot_length),]
data
rownames(data) <- NULL
View(data)


#replace Missing data with median method
median(data['foot_length'], na.rm = T)
med_m<-median(data[data$gender == 'M' , 'foot_length'], na.rm = T)
data[is.na(data$foot_length)&data$gender=='M', 'foot_length'] <-med_m


#Re-coding means use different values for a variable.
data$gender_code[data$gender == "M"] = "1"
data$gender_code[data$gender == "F"] = "2"
data


#sort data according to age using dplyr Package
data2 <- data %>% arrange(age)
data2
