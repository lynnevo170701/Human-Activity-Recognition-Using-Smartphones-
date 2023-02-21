---
title: CodeBook
author: Lynne Vo
date: 21-02-2023
output:
md_document:
variant: markdown_github
editor_options: 
  markdown: 
    wrap: 72
---

# Getting and Cleaning Data Project

Author: Lynne Vo\
Final project of the course "Getting and Cleaning Data" operated by
Johns Hopkins University.

## Metadata

**Dataset name**: Human Activity REcognition Using Smartphones\
**Citation**: Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra
and Jorge L. Reyes-Ortiz. A Public Domain Dataset for Human Activity
Recognition Using Smartphones. 21th European Symposium on Artificial
Neural Networks, Computational Intelligence and Machine Learning, ESANN
2013. Bruges, Belgium 24-26 April 2013.\
**URL**: [UCI Machine Learning
Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones#)\
**Date Donated**: 2012-12-10\
**Source**:\
Jorge L. Reyes-Ortiz(1,2), Davide Anguita(1), Alessandro Ghio(1), Luca
Oneto(1) and Xavier Parra(2) 1 - Smartlab - Non-Linear Complex Systems
Laboratory DITEN - Università degli Studi di Genova, Genoa (I-16145),
Italy. 2 - CETpD - Technical Research Centre for Dependency Care and
Autonomous Living Universitat Politècnica de Catalunya (BarcelonaTech).
Vilanova i la Geltrú (08800), Spain activityrecognition '\@' smartlab.ws

## Data set information

The experiments have been carried out with a group of 30 volunteers
within an age bracket of 19-48 years. There are six activities (Walking,
Walking_upstairs, Walking_downstairs, Sitting, Standing, Laying). A
smartphone (Samsung Galaxy S II) was used on the waist of each person.
With its embedded accelerometer and gyroscope, 3-axial linear
acceleration and 3-axial angular velocity at a constant rate of 50Hz
were retrieved. The volunteers were splitted into two types of dataset:
70% of which was used for training data, 30% of which was used for test
data.

## Attribute Information

For each record in the dataset it is provided:

\- Triaxial acceleration from the accelerometer (total acceleration) and
the estimated body acceleration.

\- Triaxial Angular velocity from the gyroscope.

\- A 561-feature vector with time and frequency domain variables.

\- Its activity label.

\- An identifier of the subject who carried out the experiment.

## Transformations

1.  Download file: with the embedded link, use download.file function to
    download and unzip function to unzip file into current working
    directory

2.  Read the activity names + features:

    -   Using read.table function to read .txt files

    -   Using grep function to find indices of mean and standard
        deviation features

    -   With the indices above, subset a data with only the required
        measurements

3.  Read data sets:

    -   X_train.txt file is the main data set; y_train.txt contains
        activity number; subject_train.txt lists all the subjects
        (volunteers labelled from 1-30) of each sample

    -   Using cbind function to combine these three files into one main
        data set for each type (train and test)

    -   Using rbind function to merge two main data sets

4.  Changing activity names:

    -   The activity numbers from "\^y\_(train\|test).txt\$" also the
        indices of them in the activity_labels.txt.

    -   Subset the names of activities with these indices

    -   Replace the numbers with the names

5.  Average of each variable for each activity and each subject:

    -   Using tidyverse package

    -   Group_by function can group variable into each activity and each
        subject before calculating average

6.  Export tidy_data data into a .txt file

## Variables and Data

-   `activity_labels` and `features` contain information from the files
    "activity_labels.txt" and "features.txt"
-   `mean_std_indices` is used to find the indices of columns that have
    mean and standard deviation.
-   `measurements` lists all the names of the measurements.
-   `train_df` is the main data set that has activity labels (retrieved
    from file y_train.txt and loaded to `train_labels`) and subjects
    (volunteers labelled from 1 to 30 retrieved from file
    subject_train.txt and loaded to `train_subject`).
-   `test_df` is another main data set that has activity labels
    (retrieved from file y_test.txt and loaded to `test_labels`) and
    subjects (retrieved from file subject_test.txt and loaded to
    `test_subject`)
-   `merged_df` is a combined files from two main data sets (`train_df`
    and `test_df`).
-   `tidy_data` is assigned by `merged_df`with all the average variable
    of each activity and each subject.
