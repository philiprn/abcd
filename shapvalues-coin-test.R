library(coin)

################################################################################
# Load the Shapley values on the trainset

shap_values <- read.csv("shap_sdq_trainset.csv")[,-1]

# # Then remove from the SHAP matrix
shap_values <- shap_values[,-which(colSums(abs(shap_values)) == 0)]

################################################################################
# Get the outcome values of the test set

X <- read.csv("synthetic-dataset.csv")

ybin <- rep(0,nrow(X))
ybin[which(X$TotaalSDQkind_f5 >= quantile(X$TotaalSDQkind_f5,0.9))] <- 1

################################################################################
# Get the train set

y_train <- ybin[read.table("trainset_indices.csv")[,1] + 1]

################################################################################
# Conditional independence tests

nc <- ncol(shap_values)
cn <- colnames(shap_values)
npps <- c()
shap_imp_rank <- rep(NA,length(cn))
for(k in 1:nc){
  print(cn[k])
  shap_imp_rank[k] <- which(colnames(shap_values)[
    order(colSums(abs(shap_values)),decreasing = TRUE)] == cn[k])
  
  offsets <- rowSums(shap_values[,-k])
  qs <- quantile(offsets, p=seq(0,1,by=0.05), na.rm = TRUE)
  whblock <- function(x) which(qs>x)[1]
  blocks <- sapply(offsets, whblock)
  dattest <- data.frame(y_train, vartest = shap_values[,k], blocks=factor(blocks))
  newp <- pvalue(independence_test(y_train ~ vartest | blocks, data = dattest)) 
  print(newp)
  npps <- c(npps,newp)
}

################################################################################
# Compare rankings

results <- data.frame(name = cn[order(npps)],
                      pvalue = sort(npps), 
                      SHAP = shap_imp_rank[order(npps)])

head(results, 10)
