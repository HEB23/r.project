 #install packages
install.packages("dplyr")
install.packages('tidyr')


#Load the libraries
library(tidyr)
library(dplyr) 
install.packages("tidyverse")
library(tidyverse)

  
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


#data visualization
data<-as.tibble(data)
data
q<- ggplot(data, aes(M,f))
q
q + geom_point()
data
hist<- ggplot(data = data,aes(x=age, fill= gender))
hist
hist + geom_histogram(binwidth = 5 ,,
                      ,alpha=0.5) + 
  ggtitle("Age")+ labs(y="Num of members",x="Age")

#bar chart
data
bar<-ggplot(data, aes(x=gender_code , fill= gender))
bar+ geom_bar() + theme_light() + labs(y= "num of", title = "gender rate") 

#box blot
data
my_box <- ggplot(data, aes(x= gender_code, y=age , group = gender_code))
my_box + geom_boxplot() + geom_jitter(width = 0.2 , aes(color=gender))
  labs(title = "gender rate" ) +
  theme_light()
  
#scatter blot
sp<- ggplot(data , aes(foot_length,height))
sp+ geom_point(aes(color=gender), shape= 21 , fill ="white", size= 2 , stroke = 2) + theme_light() 
labs(x="foot length", y ="hright" , title = "scatter plot") + stat_density2d()


