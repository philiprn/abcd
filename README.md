# abcd

This repository accompanies the paper:

*Predictor discovery for mental health at adolescence in epidemiological cohort data using tree-based models and SHAP*

Philip Rutten, Susanne de Rooij, Mark van de Wiel

## Jupyter notebook
In the notebook we provide an example of the analysis pipeline as described in the paper.
We use Python 3.9.25, and the CatBoost (v.1.2.7), SHAP (v.0.48.0), and Scikit-learn (v.1.5.1) libraries.
We analyze a synthetic version of the data, as the original data cannot be shared due to privacy regulations. 

## Conditional independence tests
In the R script we run conditional independence tests, using the coin package, on the SHAP values calculated on the test data.
The script creates a comparison of different rankings, as described in the paper.

## Synthetic data
In the R script we generate a synthetic copy of the original data using the R package **synthpop**.
In the synthetic dataset all original values are replaced with synthetic ones which mimic the original data and preserve the relationships between variables.
This ensures that analysis results are qualitatively similar as compared to the real data.

The synthetic dataset is a copy of the top 50 most important variables of the dataset (up to phase 4, age 11-12, $p=380$), together with a synthetic version of the outcome variable (SDQ score at age 15-16).
The dataset is generated as follows.
We synthesize the variables in reversed order, which means that we start with the outcome and then iterate from the most important variable down the list to the least important variable.
The outcome variable, as the first predictor, is randomly sampled, which is then used to synthesize the next one, using a classification and regression tree algorithm.
The last variable is synthesized using all other variables as predictors.
This generates a dataset which is expectedly a stronger version of itself, so to speak. 
This suits the illustrative purpose of the dataset.

