# Do We Judge Children's Books by Their Covers? Exploring Title, Exclamation Marks, and Reviewer Bias

## Overview
This paper using data from Goodreads to examine the impact of first impressions on children's book ratings, focusing on how attributes such title, page count, and review count influence ratings.  Using both simple linear regression and fine-tuned transformer models ([model card](utdqi.github.io/children_book_review/), we found that book titles alone explained 7.94% of the variation in ratings, indicating the significance of first impressions. This study provide support for previous studies in concluding that children may favor the theme of excitement and celebration, which are useful in building recommendation system and selecting optimal titles.

## File Structure

The repo is structured as:

-   `data/00-simulated_data` contains the simulated dataset.
-   `data/01-raw_data` contains raw data downloaded from https://mengtingwan.github.io/data/goodreads (not uploaded due to licensing concerns, but can be dowloaded using 02-download_clean_model_data.ipynb by user)
-   `data/02-analysis_data` contains the cleaned dataset that was constructed form raw data.
-   `models` contains the rds file for linear regression and transformer model. (Transformer model is too large(>100m) to be uploaded, the code in 02-download_clean_model_data.ipynb is deterministic, running this code will produce the same model)
-   `other` contains details about LLM chat interactions, and sketches.
-   `docs` contains required files for website publication
-   `paper` includes the paper's PDF and the files used to create it, such as the Quarto manuscript and reference bibliography file. 
-   `scripts` contains the R and python scripts used to simulate, download, clean, test and model data. 

## Statement on LLM usage
Some of the code was written with the help of the ChatGPT-4o model, which also advice with language and grammar, it have also provided suggestion on the title. other/llm_usage/usage.txt contains the entire chat history.

## Acknowledgments
We appreciate your time in reviewing this paper and would be grateful for any feedback or suggestions you may have.
