# XGB Preprocessing
# -------------------------------------------------------------------
train <- list()
train$data <- df_month %>% 
  filter(set == "train") %>%  
  select(-set, -target) %>% 
  as.matrix()

train$label <- df_month %>% filter(set == "train") %>%
  pull(target)

dtrain <- xgb.DMatrix(data = train$data, label = train$label, missing = NaN)
# -------------------------------------------------------------------
validate <- list()
validate$data <- df_month %>% 
  filter(set == "validation") %>%  
  select(-set, -target) %>% 
  as.matrix()

validate$label <- df_month %>% filter(set == "validation") %>%
  pull(target)

validate <- xgb.DMatrix(data = validate$data, 
                         label = validate$label,
                         missing = NaN)
# -------------------------------------------------------------------
test <- list()
test$data <- df_month %>% 
  filter(set == "test") %>%  
  select(-set, -target) %>% 
  as.matrix()

test$label <- df_month %>% filter(set == "test") %>%
  pull(target)

test <- xgb.DMatrix(data = test$data, 
                         label = test$label,
                         missing = NaN)
# ---------------------------------------------------------------------
# XGB Parameter, see https://xgboost.readthedocs.io/en/latest/parameter.html
nround = 30

param_tree <- list(booster = "gblinear", # "gblinear" or "gbtree"
                   verbosity = 0, # (silent), 1 (warning), 2 (info), 3 (debug)
                   validate_parameters = TRUE, 
                   "objective" = "reg:squarederror", 
                   base_score = 0.5,
                   "eval_metric" = "rmse",
                   "eta" = 0.075, 
                   "gamma" = 0.1,
                   "max_depth" = 20,
                   "min_child_weight" = 25,
                   "subsample" = 0.6,
                   "colsample_bytree" = 0.5)

# TODO Work further from here

# XGB Crossvalidation
xgb.cv(params = param_tree, data = dtrain, nrounds = nround, nfold =4,
       prediction = FALSE, showsd = TRUE, metrics = list("rmse"),
       stratified = TRUE,
       verbose = F, print.every.n = 1L)
# Training
bst <- xgb.train(params = param_tree, data = dtrain, nrounds = nround)
# Predictions
pred <- predict(object = bst, newdata = dnew)
# Submission
library(dplyr)
submission <- cbind.data.frame(ID = new_id, TARGET = pred) %>% arrange(ID)
dim(submission)
# Write Data
write.csv(submission, "sub1.csv", na="", quote = FALSE, row.names = FALSE)