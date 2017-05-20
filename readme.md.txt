This readme.txt file describes the approach to loading and cleaning the data for the week 4 project.

Packages/Librabies:

The script uses plyr, tidyr, and reshape2 libraries. These packages and libraries are called at the beginning of the script and may produce warning messages if the packages are already installed in the workspace.

Data Files:

Common data file in the working directory:

activity_labels.txt : file contains the descriptions associated with each of the types of activity. This information is needed to make the final tidy table more descriptive1

1
WALKING
2
WALKING_UPSTAIRS
3
WALKING_DOWNSTAIRS
4
SITTING
5
STANDING
6
LAYING

features.txt: file contains the feature description associated with each of the feature codes in the data file (X_test, X_train)

Files in the test subdirectory
The test directory contains the observation data for the 30% of subjects assigned to the “test” group. 

Each file in the test directory is a component of the observation. All 3 files have the same number of rows and can thus be easily merged together to form a single data set.

subject_test.txt – file contains the data for each subject
Y_test – file contains the activity id for each observation
X_test – file contains the values for each feature for each observation

Files in the train subdirectory
The train directory contains the observation data for the 70% of subjects assigned to the “train” group. 

Each file in the train directory is a component of the observation. All 3 files have the same number of rows and can thus be easily merged together to form a single data set.

subject_train.txt – file contains the data for each subject
Y_train – file contains the activity id for each observation
X_train – file contains the values for each feature for each observation

General Flow of the cleaning script:

Load necessary packages and libraries

Load common reference tables form the working directory; activity labels, feature descriptions. Rename the columns for better readability.

Load data and build data frame for the “test” data
1. import the 3 files: subject_test, X_test, Y_test
2. use cbind to create a singe table (all the files have the same number of rows)
3. rename the columns to make them more usable
4. collapse the feature values for each observation to create a “long tidy” data set
5. add a field to store the description of each feature, this is useful in the next step where we filter the data so that we are only looking at features related mean and std measurements. Also, it is critical maintain the original feature_id codes in the data as the descriptions are not 1:1 to each code. There are multiple feature codes with the same description.
6. also added an additional column to track the origin of the observation (“test” or “train”) I never used it, but it seemed to be good practice to keep track of where things came from and for some future analysis. Saves having to go back and reference the subject_test file in the future.
7. filter out using grepl to only use feature measurements related to mean and standard deviation 

Load data and build data frame for the “train” data
	Basically the same as above with the train folder

Combine the  test and train data frames using rbind

Cleanup the data set
	add the activity description column per instructions
	rename all the column names, specifically those columns created during the melt function
	reorder the columns based on key data and the observed value at the far right

Create the summarized dataframe per the instructions
	group the data by subject_id,activity_id, feature_id
	summarize the mean of the values in each group
	store the new data in a dataframe called sumdf
	add the activity descriptions and feature descriptions to make it more readable
	reorder the columns for readability

Output each of the 2 dataframes to text files without row names per instructions


	
