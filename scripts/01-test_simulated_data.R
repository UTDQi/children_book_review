#### Preamble ####
# Purpose: Tests the structure and validity of the simulated Data
# Author: David Qi 
# Date: 01 December 2024
# Contact: david.qi@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
  # - The `tidyverse` package must be installed and loaded
  # - 00-simulate_data.R must have been run
# Any other information needed? No


#### Workspace setup ####
library(tidyverse)

book_data <- read_csv("data/00-simulated_data/simulated_data.csv")

# Test if the data was successfully loaded
if (exists("book_data")) {
  message("Test Passed: The dataset was successfully loaded.")
} else {
  stop("Test Failed: The dataset could not be loaded.")
}


#### Test Book data ####

# Check if the dataset has 20 rows
if (nrow(book_data) == 20) {
  message("Test Passed: The dataset has 20 rows.")
} else {
  stop("Test Failed: The dataset does not have 20 rows.")
}

# Check if the dataset has 5 columns
if (ncol(book_data) == 5) {
  message("Test Passed: The dataset has 5 columns.")
} else {
  stop("Test Failed: The dataset does not have 5 columns.")
}

# Check if the dataset has duplicates
if (!any(duplicated(book_data))) {
  message("Test Passed: The dataset has no duplicates")
} else {
  stop("Test Failed: The dataset does not has duplicates")
}     
     
# Check if the dataset has 5 columns
if (ncol(book_data) == 5) {
  message("Test Passed: The dataset has 5 columns.")
} else {
  stop("Test Failed: The dataset does not have 5 columns.")
}

# Check if average rating is between 1 and 5
if (all(book_data$mean_rating >= 1 & book_data$mean_rating <= 5)) {
  message("Test Passed: rating is between 1 and 5")
} else {
  stop("Test Failed: There are rating outside 1 to 5")
}


# Check if there are any negative values for pages
if (all(book_data$num_page >= 0)) {
  message("Test Passed: Books all have positive number of pages")
} else {
  stop("Test Failed: There exist negative or 0 page book")
}

# Check if there are any negative values for number of reviews
if (all(book_data$num_review > 0)) {
  message("Test Passed: Books all have non-negative number of reviews")
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

# Check if publication date are in the past
if (all(book_data$publication_date <= as.Date("2024-12-01","%Y-%m-%d"))) {
  message("Test Passed: All books are published in the past")
} else {
  stop("Test Failed: There is book published in the future")
}



