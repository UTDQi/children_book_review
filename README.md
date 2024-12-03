# Paper On Children's book

## Overview
This repository is implemented by R and python, including all necessary code, data, model and analysis used to analysis children's book rating from goodreads.com.


## File Structure

The repo is structured as:

-   `data/00-simulated_data` contains the simulated dataset.
-   `data/01-raw_data` contains raw data downloaded from https://mengtingwan.github.io/data/goodreads (not uploaded due to licensing concerns, but can be dowloaded using 02-download_clean_model_data by user)
-   `data/02-analysis_data` contains the cleaned dataset that was constructed.
-   `models` contains the rds file for linear regression and transformer model.(Transformer model is too large(>100m) to be uploaded, the code in 02-download_clean_model_data is deterministic, running this code will produce the same model)
-   `other` contains details about LLM chat interactions, and sketches.
-   `paper` includes the paper's PDF and the files used to create it, such as the Quarto manuscript and reference bibliography file. 
-   `scripts` contains the R scripts used to simulate, download, clean, test data. Also contain analysis data and data modeling.

## Statement on LLM usage

Some of the code was written with the help of the ChatGPT-4o model, which also helped with language paraphrase. Other/llm_usage/usage.txt contains the entire chat history.

