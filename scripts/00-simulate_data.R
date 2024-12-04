#### Preamble ####
# Purpose: Simulates a dataset of polling results, which include polls and the support rate of Kamala Harris and Donald Trump. And simulate DJIA index. 
# Author: David Qi
# Date: 01 December 2024
# Contact: david.qi@mail.utoronto.ca
# License: MIT
# Pre-requisites: The `tidyverse` package must be installed
# Any other information needed? Make sure you are in the correct r project


#### Workspace setup ####
library(tidyverse)
set.seed(853)

#### Simulate data ####

book_names <- c(
  "Pride and Prejudice",
  "To Kill a Mockingbird",
  "1984",
  "The Great Gatsby",
  "Moby-Dick",
  "War and Peace",
  "The Catcher in the Rye",
  "Jane Eyre",
  "Crime and Punishment",
  "The Hobbit",
  "Brave New World",
  "The Lord of the Rings",
  "The Alchemist",
  "The Kite Runner",
  "One Hundred Years of Solitude",
  "The Grapes of Wrath",
  "The Da Vinci Code",
  "Harry Potter and the Sorcerer's Stone",
  "The Hunger Games",
  "The Road"
)
n_books <- length(book_names)   # Number of rows(books)
mean_rating  = 4
sd_rating  = 0.1
max_page = 500
max_review = 10000
dates <- seq(as.Date("2022-09-12","%Y-%m-%d"), to = as.Date("2024-09-12","%Y-%m-%d") ,by = "month")



# Simulate book data
book_data <- data.frame(
  title = book_names,
  mean_rating = pmin(pmax(rnorm(1,mean = mean_rating,sd = sd_rating), 1), 5),
  num_review = sample(1:max_review, n_books,replace = TRUE),
  num_page = sample(1:max_page, n_books,replace = TRUE),
  publication_date = dates[1:n_books]
)




#### Save data ####
write_csv(book_data, "data/00-simulated_data/simulated_data.csv")