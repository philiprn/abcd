# abcd

This repository accompanies the paper:

*Predictor discovery in epidemiological cohort data using Machine Learning techniques*

Philip Rutten, Susanne de Rooij, Mark van de Wiel

In the notebook we provide a step-by-step walk-through of the analysis pipeline.
The data analyses are implemented in Python 3.9.20, using the CatBoost (v.1.0.6) and SHAP (v.0.46.0) libraries, and Scikit-learn (v.1.2.2).
In the online notebook we analyze a synthetic version of the data, as the original data cannot be shared due to privacy regulations. 

In the R script we generate a synthetic copy of one of the original datasets (analysed in the paper) using the R package synthpop.
In the synthetic dataset all original values have been replaced with synthetic ones which mimic the original data and preserve the relationships between variables.
This ensures that analysis results are qualitatively similar as compared to the real data.

The synthetic dataset is a copy of the top 50 most important variables of the phase 4 (age 11-12, $p=380$) dataset, together with a synthetic copy of the outcome variable SDQ score (age 15-16).
The dataset is generated as follows.
We synthesize the variables in reversed order, meaning we start with the outcome and then iterate from the most important variable down the list to the least important variable.
This means that the outcome variable is randomly sampled as the first predictor, which is then used to synthesized the next one, using classification and regression trees (CART).
To synthesize the last variable we use all previous variables as predictors.
This generates as dataset which is a stylized version of itself, so to speak. 
This suits the illustrative purpose of the demonstration code.

