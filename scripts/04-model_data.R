#### Preamble ####
# Purpose: Test various models and choose one to save
# Author: David Qi
# Date: 01 December 2024
# Contact: david.qi@mail.utoronto.ca 
# License: MIT
# Pre-requisites: cleaned_books.parquet in data/02-analysis_data
# Any other information needed? No


#### Workspace setup ####
library(tidyverse)
library(arrow)

#### Read data ####
book_data <- read_parquet("data/02-analysis_data/cleaned_books.parquet") 

### Model data ####
# prepare data

# Convert the date columns to Date format
book_data =book_data %>% mutate( publication_date =  as.Date(
  paste(book_data$publication_year, book_data$publication_month, book_data$publication_day, sep = "-", format = "%Y-%m-%d")
)
)

book_data =book_data %>% filter( ratings_count > 0)

book_data =book_data %>% mutate( publication_day_in_year =   as.integer(format(as.Date(paste(book_data$publication_year, book_data$publication_month, book_data$publication_day, sep = "-")), "%j")),
                                 text_reviews_ratio = text_reviews_count/ratings_count
)

# Fit the linear regression model
model <- lm(average_rating ~  publication_day + publication_year + num_pages + text_reviews_count  +  text_reviews_ratio  + publication_day_in_year, data = book_data)

# Summarize the model
summary(model)
AIC(model)

# Recorded AIC of tested models: 
# average_rating ~  publication_dates: 55177.35
# average_rating ~  publication_day + publication_month +publication_year: 54936.49
# average_rating ~  publication_day + publication_month +publication_year + ratings_count + (publication_day*publication_month):  54885.92
# average_rating ~  publication_day + publication_month + publication_year + ratings_count + text_reviews_count + (publication_day*publication_month): 54806.46
# average_rating ~  publication_day + publication_month + publication_year + text_reviews_count + (publication_day * publication_month): 54809.09
# average_rating ~  publication_day + publication_month + publication_year + num_pages + text_reviews_count + (publication_day*publication_month): 52818.41
# average_rating ~  publication_day + publication_month + publication_year + num_pages + text_reviews_count+ratings_count  + (publication_day*publication_month): 52815
# average_rating ~  publication_day + publication_month + publication_year + num_pages + text_reviews_count+ratings_count  + (publication_day_in_year): 52816.09
# average_rating ~  publication_day + publication_year + num_pages + text_reviews_count+ratings_count  + (publication_day_in_year): 52823.73
# average_rating ~  publication_day + publication_year + num_pages + text_reviews_count  + (publication_day_in_year): 52827.11
# average_rating ~  publication_day + publication_year + num_pages + text_reviews_count + text_reviews_count/ratings_count + publication_day_in_year: 52785.39
# average_rating ~  publication_day + publication_year + num_pages + ratings_count  +  text_reviews_count/ratings_count  + publication_day_in_year: 52735.15
# average_rating ~  publication_day + publication_year + num_pages + text_reviews_count  +  text_reviews_ratio  + publication_day_in_year: 52528.23 (Chosen model)
# average_rating ~  publication_day + publication_year + num_pages + ratings_count +  text_reviews_ratio  + publication_day_in_year: 52779.03

# average_rating ~  publication_day + num_pages + text_reviews_count  +  text_reviews_ratio  + publication_day_in_year: 52526.61
# average_rating ~  publication_day + publication_month + num_pages + text_reviews_count  +  text_reviews_ratio  + publication_day_in_year:52519.67
# average_rating  ~  publication_day + publication_month + num_pages + text_reviews_count  +  text_reviews_ratio + ratings_count  + publication_day_in_year: 52515.81 (Best AIC)


# Make predictions using the model
predictions <- predict(model, newdata = book_data)

# Compute the absolute difference between predicted ratings and actual ratings
abs_diff <- abs(predictions - book_data$average_rating)

# Compute the accuracy: how many predictions are within 0.25 of the true rating
accuracy_within_0_25 <- sum(abs_diff <= 0.25) / length(predictions) * 100

# Print the accuracy
cat("Accuracy within 0.25 of target: ", accuracy_within_0_25, "%\n")




#### Save model ####
saveRDS(model, file = "models/model_linear.rds")