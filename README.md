## Project for the Coursera Course Getting and Cleaning Data

The submission consists of CodeBook.md, the file run_analysis.r that is used to tidy the data according to the requirements and this README.md file.

The data can be found at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

and the explanation of the experiment can be found at

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The purpose of the experiment is to recognize activity performed by a person by the measurements provided by their smartphone's accelerometer and gyroscope. 

For a complete description of the data, please refer to the README.txt file that is included with the data.

The zip folder at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip includes the following files (for a full list and more details check README.txt included in the zip folder):

- 'README.txt'
- 'features_info.txt': Shows information about the variables used on the feature vector.
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.

The data contains measurements of the 3-axial linear acceleration and 3-axial angular velocity (sampled at a constant rate of 50Hz) from the cell phones of 30 subjects performing 6 activities (WALKING, WALKING UPSTAIRS,  WALKING DOWNSTAIRS, SITTING, STANDING, LAYING). For details look at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones and the README.txt file that is given in the zip file with the data.

The requirement of the assignment is to create one R script called run_analysis.R that does the following. 

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set.
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

    
    Here are the details of each step:

####1. Merge the training and the test sets to create one data set

The data for train sets are given in the train folder. Namely, 

- "UCI HAR Dataset/train/X_train.txt" - each row contains the actual measurements for a window sample, 
- "UCI HAR Dataset/train/subject_train.txt" - each row identifies the subject who performed the activity for each window sample.
- "UCI HAR Dataset/train/y_train.txt" - each row identifies the activity performed by the subject

The first task of the script is to column bind the above train data in a data frame train.data.

The data for test sets are given in the test folder. Namely, 

- "UCI HAR Dataset/test/X_test.txt" - each row contains the actual measurements for a window sample, 
- "UCI HAR Dataset/test/subject_test.txt" - each row identifies the subject who performed the activity for each window sample.
- "UCI HAR Dataset/test/y_test.txt" - each row identifies the activity performed by the subject

The script column binds the above test data in the data frame test.data.

The data frame data is obtained by row binding test.data and train.data. (The data frame data contains the merge of the training and the test sets.)

The names of the features are in the file UCI HAR Dataset/features.txt. These names together with the two extra strings, subjectID and activity, are used for column names of the data frame data. 

####2.Extract only the measurements on the mean and standard deviation for each measurement

The grep command is used to select only the columns representing the mean and standard deviation for each measurement, and the subsetted data is stored in the data.frame selected.data. 

Note that data, train.set, test.set data frames are removed because they are no needed for further analysis.

Also note that only columns that had brackets after mean or std were selected, as the file features_info.txt specifies these as measurements.  For example fBodyAcc-meanFreq()-X is not selected because it is specified as estimation in the same file.

#### 3. Use descriptive activity names to name the activities in the data set

The data frame selected.data contains numeric values for the activities. The file UCI HAR Dataset/activity_labels.txt specifies the descriptive names for the numeric values. In this step the numeric values in the activity column of the selected.data are replaced by the corresponding activity labels given in the file UCI HAR Dataset/activity_labels.txt.

#### 4. Appropriately label the data set with descriptive variable names. 

This step tidies the column names. Here 

- we remove the duplication of the word Body from some headings,
- replace the trailing t with the word time,
- replace the trailing f with the abbreviation freq,
- swap the words mean or std and the direction (X, Y, Z) and remove the brackets and the dash. For example "freqBodyGyro-mean()-X" becomes "freqBodyGyroXmean". This is primarily done so that the last word in the column name is either mean or std,
- remove '-' before std or mean in names that do not contain direction. For example "freqBodyAccJerkMag-std()" becomes "freqBodyAccJerkMagstd",
- capitalize the word mean,
- capitalize the word std - seems like the right thing to do.

Note the these steps are well documented in the script and you can remove any of them if you prefer the original names.

#### 5. From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.

This part is achieved in two steps. First, the data is summarized as a data frame summary.data that contains the average of each variable for each activity and each subject.

summary.data is not tidy since most of the variables are just dimensions of the same measurements. So, the data is tidyied to contain 4 columns: subjectID, activity, measurement, meanValue. The obtained data frame is called tidy.data





 
  


