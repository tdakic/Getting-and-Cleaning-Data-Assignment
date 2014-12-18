## Code Book

The raw data for this project can be found at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip. This folder contains README.txt file that describes the experiment, features.txt that gives the measured features and features_info.txt that describes the features.

### Variables  

#### subjectID  

**Description:** ID of the test subject  
**Type:** Integer  
**Values:** 1..30  
**Transformation:** No transformation. Exactly as in the raw data.

#### activity  

**Description:** Activity performed by the test subject  
**Type:** Factor with 6 levels  
**Values:** LAYING, SITTING, STANDING, WALKING, WALKING DOWNSTAIRS, WALKING UPSTAIRS  
**Transformation:** Almost identical as in the raw data. The only difference is the removed underscore in the activities that consist of two words.

#### measurement   

**Description:** Measurement performed  
**Type:** Factor with 66 levels  
**Values:**   

 timeBodyAccXMean  
 timeBodyAccYMean  
 timeBodyAccZMean  
 timeBodyAccXSTD        
 timeBodyAccYSTD  
 timeBodyAccZSTD  
 timeGravityAccXMean  
 timeGravityAccYMean     
 timeGravityAccZMean  
 timeGravityAccXSTD  
 timeGravityAccYSTD  
 timeGravityAccZSTD       
 timeBodyAccJerkXMean  
 timeBodyAccJerkYMean  
 timeBodyAccJerkZMean  
 timeBodyAccJerkXSTD      
 timeBodyAccJerkYSTD  
 timeBodyAccJerkZSTD  
 timeBodyGyroXMean  
 timeBodyGyroYMean       
 timeBodyGyroZMean   
 timeBodyGyroXSTD  
 timeBodyGyroYSTD  
 timeBodyGyroZSTD         
 timeBodyGyroJerkXMean  
 timeBodyGyroJerkYMean  
 timeBodyGyroJerkZMean  
 timeBodyGyroJerkXSTD     
 timeBodyGyroJerkYSTD  
 timeBodyGyroJerkZSTD  
 timeBodyAccMagMean  
 timeBodyAccMagSTD       
 timeGravityAccMagMean  
 timeGravityAccMagSTD  
 timeBodyAccJerkMagMean  
 timeBodyAccJerkMagSTD   
 timeBodyGyroMagMean  
 timeBodyGyroMagSTD  
 timeBodyGyroJerkMagMean  
 timeBodyGyroJerkMagSTD   
 freqBodyAccXMean  
 freqBodyAccYMean  
 freqBodyAccZMean  
 freqBodyAccXSTD          
 freqBodyAccYSTD  
 freqBodyAccZSTD  
 freqBodyAccJerkXMean  
 freqBodyAccJerkYMean     
 freqBodyAccJerkZMean  
 freqBodyAccJerkXSTD  
 freqBodyAccJerkYSTD  
 freqBodyAccJerkZSTD  
 freqBodyGyroXMean  
 freqBodyGyroYMean  
 freqBodyGyroZMean  
 freqBodyGyroXSTD         
 freqBodyGyroYSTD  
 freqBodyGyroZSTD  
 freqBodyAccMagMean  
 freqBodyAccMagSTD        
 freqBodyAccJerkMagMean  
 freqBodyAccJerkMagSTD  
 freqBodyGyroMagMean  
 freqBodyGyroMagSTD       
 freqBodyGyroJerkMagMean  
 freqBodyGyroJerkMagSTD  
 
 **Transformation:** Only columns that contained mean() or std() were taken from the raw data. 
 The names were slightly changed, mostly to clean up and standardize:
 
 - the duplication of the word Body was removed from some headings,
 - trailing t is replaced with the word time,
 - trailing f with is replaced with the abbreviation freq,
 - the words mean or std and the direction (X, Y, Z) were swapped and brackets and dash removed.  For example "freqBodyGyro-mean()-X" becomes "freqBodyGyroXmean". This is primarily done so that the last word in the column name is either mean or std,
 -  '-' before std or mean in names that do not contain direction was removed. For example "freqBodyAccJerkMag-std()" becomes "freqBodyAccJerkMagstd",
 - the word mean was capitalized
 - the word std was capitalized - seemed like the right thing to do.
 
Note that the names are still very similar to the names in the row data.

#### meanValue 

**Description:**   Mean of all the values from the raw data corresponding to the given measurement when given subject is performing given action.  
**Type:** Number   
**Values:** [-1,1] as the values are normalized in the row data   
**Transformation:** The mean of each measurement for each activity and each subject is computed. The units  are the same as in the raw data, because calculating mean doesn't affect units.