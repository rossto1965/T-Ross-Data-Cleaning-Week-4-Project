run_analysis <- function(){
 
 #loadup necisary packages and libraries 
  install.packages("plyr")
  install.packages("tidyr")
  install.packages("reshape2")
  library(plyr)
  library(tidyr)
  library(reshape2)
  
  ## Read in common files
  activity_labels <- read.table("activity_labels.txt")
  colnames(activity_labels) <- c("activity_id", "activity_desc")
  features <- read.table("features.txt")
  colnames(features) <- c("feature_id", "feature_desc")
  feature_list <- features$feature_desc
  
  ## Read in test data
  x_test <- read.table("./test/X_test.txt")
  y_test <- read.table("./test/Y_test.txt")
  subject_test <- read.table("./test/subject_test.txt")
  # Build testdat table
  testdata <- subject_test
  testdata <- cbind(testdata,y_test)
  testdata <- cbind(testdata,x_test)
  colnames(testdata) <- c("subject_id","activity_id", 1:561)
  testdata <- melt(testdata,id.vars=c("subject_id","activity_id"))
  testdata<-mutate(testdata,feature_desc=feature_list[as.numeric(variable)],dataset="test")
  testdata <- filter(testdata, grepl("mean|std",feature_desc))
  
  ##Read in train data
  x_train <- read.table("./train/X_train.txt")
  y_train <- read.table("./train/Y_train.txt")
  subject_train <- read.table("./train/subject_train.txt")
  #Build train table
  traindata <- subject_train
  traindata <- cbind(traindata,y_train)
  traindata <- cbind(traindata,x_train)
  colnames(traindata) <- c("subject_id","activity_id", 1:561)
  traindata <- melt(traindata,id.vars=c("subject_id","activity_id"))
  traindata<-mutate(traindata,feature_desc=feature_list[as.numeric(variable)],dataset="train")
  traindata <- filter(traindata, grepl("mean|std",feature_desc))
  
  fulldata <-testdata
  fulldata <-rbind(fulldata,traindata)
  
  
  #cleanup data set by adding activity description column, renaming columns and reordering columns
  fulldata <- mutate(fulldata,activity_desc = activity_labels[as.numeric(activity_id),2])
  colnames(fulldata)<-c("subject_id","activity_id","feature_id","value","feature_desc","dataset","activity_desc")
  fulldata <- fulldata[c(6,1,2,7,3,5,4)]
  sumdf <- summarize(group_by(fulldata,subject_id,activity_id,feature_id),meanval=mean(value))
  sumdf <- mutate(sumdf,activity_desc = activity_labels[as.numeric(activity_id),2],feature_desc=feature_list[as.numeric(feature_id)])
  sumdf <- sumdf[c(1,2,5,3,6,4)]
  write.table(fulldata, file="~/DC Week 4/DC Project/w4_proj_fulldata",row.names = FALSE)
  write.table(sumdf, file="~/DC Week 4/DC Project/w4_proj_sumdata",row.names = FALSE)
  }