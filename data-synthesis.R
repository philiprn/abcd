library(synthpop)

# We have created a dataset from the top 50 predictors
# plus the outcome variabel (SDQ score)
# Columns are in order from worst to best predictors
# And column 51 is the outcome 
# We have changed categorical variables into factors
X <- read.csv("top50-dataset.csv")

codebook.syn(X)

synX <- syn(X, visit.sequence = 51:1) 

summary(synX)

write.csv(synX$syn,"synthetic-dataset.csv",row.names = FALSE)