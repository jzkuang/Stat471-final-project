# run all steps of the analysis pipeline
source("code/1-Data-Cleaning.R")
source("code/1.5-Merging-Datasets.R")
source("code/2-train-test-split.R")
source("code/3-exploratory-data-analysis")
source("code/4-regression-modeling.R")
source("code/5.1-random-forest-modeling.R")
source("code/5.2-boosting-modeling.R")
source("code/6-model-evaluation.R")