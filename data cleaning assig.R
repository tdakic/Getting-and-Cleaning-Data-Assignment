assign_test <-read.table("UCI HAR Dataset/test/X_test.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
subject_test_activity <- read.table("UCI HAR Dataset/test/y_test.txt")

test_data <- cbind(subject_test,subject_test_activity,assign_test)

assign_train <-read.table("UCI HAR Dataset/train/X_train.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
subject_train_activity <- read.table("UCI HAR Dataset/train/y_train.txt")

train_data <- cbind(subject_train,subject_train_activity,assign_train)

features <- read.table("UCI HAR Dataset/features.txt")
new_names = c("Subject ID", "Activity")

col_names <- append(new_names,features[,2])


data <- rbind(train_data,test_data)

names(data) <- col_names

to_select <-grep("mean\\(|std\\(",col_names)
data_we_need <- data[,c(1,2,to_select)]

tidy_headings <- function(x) {
        x <- sub("BodyBody","Body",x)
        x <- sub("[t]Body","TimeBody",x)
        x <- sub("[f]Body","FreqBody",x)
        x <- gsub("(.)([[:upper:]])", "\\1 \\2", x)
        x <- sub("\\-(.+)\\(\\)\\- (.)"," \\2 \\1",x)
        x <- sub("\\-(.+)\\(\\)", " \\1",x)
        x <- sub("mean","Mean",x)
        x <- sub("std","STD",x)
}

## sapply(names(data_we_need),tidy_headings)
## for (i in 1:68) colnames(data_we_need)[i] <- tidy_headings(colnames(data_we_need)[i])


names(data_we_need)<-sapply(names(data_we_need),tidy_headings)

##hous <- read.table(header = TRUE, stringsAsFactors = FALSE)



## activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt",stringsAsFactors = FALSE)
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")

fix_activity_names <- function(x) 
{
        x <- activity_labels[x,2]
}


data_we_need$Activity <- sapply(data_we_need$Activity,fix_activity_names)

## merge1 <- merge(data_we_need1,activity_labels,by_x="Activity",by_y="Avtivity")
## plyr1 <- join(data_we_need1, activity_labels, by = "Activity")

names(data_we_need)[1] <- "ID"
good_names <- names(data_we_need)
names(data_we_need) <- make.names(names(data_we_need))

summary_data <- ddply(data_we_need,.(ID,Activity), colwise(mean))

names(summary_data) <- good_names



## summary_1_walking <- colMeans(data_we_need[data_we_need$ID ==1 & data_we_need$Activity == "WALKING",3:ncol(data_we_need)])