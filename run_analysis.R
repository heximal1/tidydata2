
##load and tidy training data

## contains column names for data
features <- read.table("features.txt")

## contains 1-30 for each subject for each observation 1x7352
subject_train <- read.table("./train/subject_train.txt")

## contains observatations 561x7352
x_train <- read.table("./train/x_train.txt", col.names = features[,2])

##contains a list of 1-6 activities
activity_labels <- read.table("activity_labels.txt")

## y_train 1x7352 lists numerics 1-6 representing activities 
y_train <- read.table("./train/y_train.txt")

## create labeled version of y_train
for (i in y_train) y_train_labeled <- activity_labels[i,2]

## combine subjects, activity labels, and observation
data_train <- cbind(Subject = subject_train, Activity = y_train_labeled, x_train)
## rename first label to "Subject" - I have no idea why this is required.
 colnames(data_train)[1] <- "Subject"

## load and tidy testing data
## contains 2-24 for each subject for each observation 1x2947
subject_test <- read.table("./test/subject_test.txt")

## contains observatations 2947 obs of 561 var
x_test <- read.table("./test/x_test.txt", col.names = features[,2])

## y_test 1x2947 lists numerics 1-6 representing activities 
y_test <- read.table("./test/y_test.txt")

## create labeled version of y_test
for (i in y_test) y_test_labeled <- activity_labels[i,2]

## combine subjects, activity labels, and observation
data_test <- cbind(Subject = subject_test, Activity = y_test_labeled, x_test)
## rename first label to "Subject" - I have no idea why this is required.
 colnames(data_test)[1] <- "Subject"

data <- rbind(data_train,data_test)

## extract measurements with colnames == means. Bind subject and activity columns
data2 <- data[,grepl("[Mm][Ee][Aa][Nn]",names(data))]
data2 <- cbind(data[,1:2],data2)

## melt data2
library(reshape2)
data3 <- melt(data2, id=c("Subject","Activity"),measure.vars=
	names(data2[3:length(names(data2))]))

data4 <- dcast(data3,Subject + Activity ~ variable, mean)

head(data2[1:4])
tail(data2[1:4])

