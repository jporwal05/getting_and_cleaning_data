---
title: "Code book for Getting and Cleaning Data course project"
author: "jporwal"
date: "12/01/2020"
---

## Overview

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz.

The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

Link to dataset: <https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>

### Details about the dataset

* Data from following files was considered for this analysis: -

  - 'features.txt': List of all features.

  - 'activity_labels.txt': Links the class labels with their activity name.

  - 'train/X_train.txt': Training set.

  - 'train/y_train.txt': Training labels.

  - 'test/X_test.txt': Test set.

  - 'test/y_test.txt': Test labels.

  - 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.

* The obtained training and test datasets were merged to generate a final dataset which is being presented after the analysis.

* The dataset contains the mean of all the measurements for each subject and the activity performed by that subject.

* The measurements taken into consideration are the mean and standard deviation for for signals across axes X, Y and Z along with derived magnitudes.

### Data not taken into analysis

* Inertial signals were not taken into consideration as it is the RAW data.

### Steps taken to process and transform the data

1. Download the file and extract the data.
2. Read the features and activity labels.
3. Begin tidying the training dataset. 
    - Load the training measurements.
    - Load the Subject data from the training set.
    - Load the activities data from the training set.
    - Merge Subject, Measurements and Activites data for the training set.
    - Not merge the activity labels by activity id in the merged training dataset.
4. Repeat the same steps with the test dataset.
5. Merge the training and test dataset.
6. Extract only the mean and standard deviation of the recorded signals.
7. Tranform column names to be neat looking.
8. Tranform the dataset to have mean(average) of all the measurements for each subject and the activity performed by that subject.