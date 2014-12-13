library(plyr)

# Read the testing data and put it in one data frame

message("Reading the testing data...")

test.set <-read.table("UCI HAR Dataset/test/X_test.txt")
test.subject <- read.table("UCI HAR Dataset/test/subject_test.txt")
test.activity <- read.table("UCI HAR Dataset/test/y_test.txt")

test.data <- cbind(test.subject,test.activity,test.set)

# Read the training data and put it in one data frame

message("Reading the training data...")

train.set <-read.table("UCI HAR Dataset/train/X_train.txt")
train.subject <- read.table("UCI HAR Dataset/train/subject_train.txt")
train.activity <- read.table("UCI HAR Dataset/train/y_train.txt")

train.data <- cbind(train.subject,train.activity,train.set)

# Read the features

message("Reading the features file...")

features <- read.table("UCI HAR Dataset/features.txt")


# make the colnames - note that Subject ID and Activity do not appear in the features.yxt
# and should therefore be added

new.headings <- c("SubjectID","Activity")
col.names <- append(new.headings,as.character(features[,2]))

# make the data frame with the data and assign it the col names derived from 
# features.txt

data <- rbind(train.data,test.data)
names(data) <- col.names

# we only need the columns 1, 2 and the ones that contain std or mean in their name
cols.to.select <-grep("mean\\(|std\\(",col.names)
selected.data <- data[,c(1,2,cols.to.select)]

# remove the clutter
message("Data successfully selected. Removing big chunks of data that is not needed anymore.")

#rm(data)
#rm(train.set)
#rm(test.set)

# Tidy the headings 

message("Tidying the headings")

tidy.heading <- function(x) {
        # remove duplication of the word Body from some headinhs
        x <- sub("BodyBody","Body",x)
        # replace the trailing t with the word Time
        x <- sub("[t]Body","TimeBody",x)
        # replace the trailing f with the abbriviation Freq
        x <- sub("[f]Body","FreqBody",x)
        # split the heading on Upper case letters
        x <- gsub("(.)([[:upper:]])", "\\1 \\2", x)
        # swap the words mean or std and the direction (X, Y, Z)
        # for example "Freq Body Acc-std()- Z" becomes "Freq Body Acc Z std"
        x <- sub("\\-(.+)\\(\\)\\- (.)"," \\2 \\1",x)
        # remove '-' before std or mean in names that do not contain direction
        # for example "Freq Body Acc Jerk Mag-std()" becomes "Freq Body Acc Jerk Mag std"
        x <- sub("\\-(.+)\\(\\)", " \\1",x)
        # capitalize the word mean
        x <- sub("mean","Mean",x)
        #capitalize the word std
        x <- sub("std","STD",x)
}

# tidy the names of selected.data - this should be done after all processing is finished,
# but it is done here to satisfy the requirements of the assignments
names(selected.data)<-sapply(names(selected.data),tidy.heading)

# make the activities in selected.data descriptive
# actvity.labels contains two columns 0 first the activity number (same as )
activity.labels <- read.table("UCI HAR Dataset/activity_labels.txt")

make.decriptive <- function(x) 
{
        x <- activity.labels[x,2]
}


selected.data$Activity <- sapply(selected.data$Activity,make.decriptive)

# I tried to accomplishthe above by using merge or join, but that created an exrat column 
# that I would to delete. Note that I did change names in activity.labels to contain
# the label "Activity"
# please tell me if you know how to accomplish the above using a single instruction
# merge(selected.data,activity.labels,by_x="Activity",by_y="Activity")
# join(selected.data, activity.labels, by = "Activity")


# make.names replaces spaces n the names with a dot
# I had to do this, because ddply wouldn't work otherwise
# I am storing the processed names and will change the names back after using ddply

good.names <- names(selected.data)
names(selected.data) <- make.names(names(selected.data))

#summarize the data as requested
summary.data <- ddply(selected.data,.(Subject.ID,Activity), colwise(mean))

# change the names back
names(summary.data) <- good.names

# write the summarized data into a file
write.table(summary.data,file = "UCI HAR Dataset/summary_data.txt", row.name=FALSE)
