## Model Card: Fine-Tuned BERT for Book Rating Prediction
This is a fine tuned BERT model to performance the regression task of predicting average book rating from titles.

### Model Details

-   **Developed by:** David Qi
-   **Model Type**: Transformer-based Regression Model
-   **Base Model**: `bert-base-uncased`
-   **Fine-Tuning Dataset**: Custom dataset (`cleaned_book_data`) containing book titles and their average ratings.
-   **Task**: Regression (predicting a continuous value for the average rating of a book)
-   **Framework**: PyTorch with HuggingFace Transformers
-   **License:** MIT

### Model Description

This model is a fine-tuned version of BERT (`bert-base-uncased`) designed to predict the **average book rating** based on the **title** of children's book. It adapts the BERT architecture for a regression task by modifying the final classification layer to output a single continuous value instead of class probabilities.

### Intended Use

-   **Primary Use Case**: Predicting the average rating for a book given its title.
-   **Intended Users**: Researchers wishing to develop a book recommendation systems or want to gain understanding of children's preference for books.

### Out-of-Scope Use
-   Prediction of rating for books of languages, genre than other than English Children's books
-   Prediction of rating from a different source with out first normalizing it. For example predict rating of children's book on amazon.  

### Model Training

-   **Optimizer**: AdamW
-   **Learning Rate**: `0.000013`
-   **Loss Function**: Mean Squared Error (MSE)
-   **Epochs**: `2`
-   **Batch Size**: `16`
-   **Device**: GPU (CUDA)

### Training Dataset

-   **Dataset Size**: 45583
-   **Features Used**:
    -   `title`: The title of the book (text input).
    -   `average_rating`: The target rating (continuous value) used for regression.

### Evaluation Results

-   **Training Loss (Final)**: 0.1236
-   **Validation Loss (Final)**: 0.1219
-   **Test Loss (MSE)**: 0.1271

### Model Performance

-   **Mean Squared Error (MSE)**: 0.1271
-   **R Squared**: 0.0794

### Limitations

-   **Dataset Limitations**: The model's performance is highly dependent on the quality and diversity of the dataset. It may not generalize well to book titles outside of the training domain. For example for genre other than children's book.
-   **Input Constraints**: The model only uses the **book title** as input, meaning it doesn't account for other potentially useful metadata like author, genre, or publication year.

### Ethical Considerations

-   **Biases in Data**: The dataset might contain biases based on the popularity or language of certain types of books, which could affect the model's predictions.
-   **Potential Misuse**: Since the model predicts ratings solely based on the title, it may misrepresent actual book quality or reader satisfaction.

## Environmental Impact

<!-- Total emissions (in grams of CO2eq) and additional considerations, such as electricity usage, go here. Edit the suggested text below accordingly -->

Carbon emissions can be estimated using the [Machine Learning Impact calculator](https://mlco2.github.io/impact#compute) presented in [Lacoste et al. (2019)](https://arxiv.org/abs/1910.09700).

-   **Hardware Type:** T4
-   **Hours used:** 5
-   **Cloud Provider:** Google CoLab
-   **Compute Region:** northamerica_northeast
-   **Carbon Emitted:** 0.01 kg eq.

### How to Use

``` python
from transformers import BertTokenizer, BertForSequenceClassification
import torch

# Load tokenizer and model
tokenizer = BertTokenizer.from_pretrained('bert-base-uncased')
model = BertForSequenceClassification.from_pretrained('path_to_fine_tuned_model', num_labels=1)
model.eval()

# Example input
title = "The Catcher in the Rye"
inputs = tokenizer(title, return_tensors="pt", max_length=128, truncation=True, padding="max_length")

# Predict average rating
with torch.no_grad():
    outputs = model(**inputs)
    predicted_rating = outputs.logits.item()

print(f"Predicted Rating: {predicted_rating:.2f}")
```