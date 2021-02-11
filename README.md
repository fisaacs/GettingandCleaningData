# GettingandCleaningData *Fielding Isaacs*
*Final project for Coursera Getting and Cleaning Data course*

This is an educational demonstration of the principles of getting and cleaning data in the R language

## Process
- Download *this* data set
- Clean it according to principles of tidy data
- Calculate means of all mean and standard deviation factors of the raw data set
- Return the tidied data set of averaged means and standard deviations to a readable text file.

## Summary of Files
- run_analysis.R - Main R source file
- CodeBook.md - variables, data, and transforms done to the initial raw data set
- README.md - *This* Readme file
- LICENSE - License info for this project
- .gitignore - Ignore file for pushing project files to repository

## Usage

### Generating the processed Data Set
- call source("run_analysis.R") with the working directory set to the project root.
- The resulting data frame "averaged" will contain the data
- The averaged data set will also be written to the project root directory under the name averages.txt

### Reading the Generated Text
- call read.table("averages.txt", header = TRUE, sep = " ") into the data frame of your choosing.