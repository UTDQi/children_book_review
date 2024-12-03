#### Preamble ####
# Purpose: Test for analysis data
# Author: David QI
# Date: 01 December 2024
# Contact: david.qi@mail.utoronto.ca 
# License: MIT
# Pre-requisites: cleaned_books.parquet in data/02-analysis_data
# Any other information needed? No.


#### Workspace setup ####
library(tidyverse)
library(arrow)

book_data <- read_parquet("data/02-analysis_data/cleaned_books.parquet") 


# Test if the data was successfully loaded
if (exists("book_data")) {
  message("Test Passed: The dataset was successfully loaded.")
} else {
  stop("Test Failed: The dataset could not be loaded.")
}

#### Test Book data ####

# Check if the dataset has 65118 rows
if (nrow(book_data) == 65118) {
  message("Test Passed: The dataset has 65118 rows.")
} else {
  stop("Test Failed: The dataset does not have 65118 rows.")
}

# Check if the dataset has 9 columns
if (ncol(book_data) == 9) {
  message("Test Passed: The dataset has 9 columns.")
} else {
  stop("Test Failed: The dataset does not have 9 columns.")
}

# Check if the dataset has duplicates
if (!any(duplicated(book_data))) {
  message("Test Passed: The dataset has no duplicates")
} else {
  stop("Test Failed: The dataset does not has duplicates")
}     

# Check if average rating is between 1 and 5
if (all(book_data$average_rating >= 1 & book_data$average_rating <= 5)) {
  message("Test Passed: rating is between 1 and 5")
} else {
  stop("Test Failed: There are rating outside 1 to 5")
}


# Check if there are any negative values for pages
if (all(book_data$num_pages >= 0)) {
  message("Test Passed: Books all have positive number of pages")
} else {
  stop("Test Failed: There exist negative or 0 page book")
}

# Check if there are any negative values for number of ratings
if (all(book_data$ratings_count >= 0)) {
  message("Test Passed: Books all have non-negative number of ratings.")
} else {
  stop("Test Failed: There exist book with negative number of ratings.")
}

# Check if there are any negative values for number of reviews
if (all(book_data$text_reviews_count >= 0)) {
  message("Test Passed: Books all have non-negative number of reviews.")
} else {
  stop("Test Failed: There exist book with negative number of reviews.")
}

# Check if there are any missing values
if (all(!is.na(book_data))) {
  message("Test Passed: The dataset contains no missing values.")
} else {
  stop("Test Failed: The dataset contains missing values.")
}

# Check if there are any empty book name
if (all(book_data$title != "")) {
  message("Test Passed: There is no book with empty title")
} else {
  stop("Test Failed: There is book with empty title")
}

# Check if number of rating is grater than number of text reviews
if (all(book_data$ratings_count >= book_data$text_reviews_count)) {
  message("Test Passed:  Number of rating is grater than or equal to number of text reviews")
} else {
  stop("Test Failed:  Number of rating is less than number of text reviews")
}


publication_dates = as.Date(
  paste(book_data$publication_year, book_data$publication_month, book_data$publication_day, sep = "-", format = "%Y-%m-%d")
)

# Check if there are any missing values in dates
if (all(!is.na(publication_dates))) {
  message("Test Passed: There is no incorrect dates.")
} else {
  stop("Test Failed: There is incorrect dates.")
}

# Check if publication date are in the past
if (all(publication_dates <= as.Date("2024-12-01","%Y-%m-%d"))) {
  message("Test Passed: All books are published in the past")
} else {
  stop("Test Failed: There is book published in the future")
}