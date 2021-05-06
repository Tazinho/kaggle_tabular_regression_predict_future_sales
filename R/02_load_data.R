# ------------------------------------------------------------------------------
# Challenge ####
# - forecast total amount of products sold in every shop
# - list of shops and products slightly changes every month.
# ------------------------------------------------------------------------------
# Data ####
# - Train on historical data from January 2013 to October 2015.
# - Predict sales for each combination of shop and product for November 2015
df_train <- data.table::fread("data/input/sales_train.csv",
                              data.table = FALSE) %>% 
  as_tibble() %>% 
  select(-date_block_num) %>% 
  mutate(date = dmy(date))

df_test <- data.table::fread("data/input/test.csv", 
                             data.table = FALSE) %>% 
  as_tibble() %>% 
  select(-ID) 
# - Submit in the form
df_ss <- data.table::fread("data/input/sample_submission.csv", 
                           data.table = FALSE) %>% 
  as_tibble()
# ID item_cnt_month
# 1  0            0.5
# 2  1            0.5
# 3  2            0.5

# Supplemental Information
df_items <- data.table::fread("data/input/items.csv", 
                              data.table = FALSE, 
                              encoding = "UTF-8") %>% 
  as_tibble()

df_item_categories <- data.table::fread("data/input/item_categories.csv", 
                                        data.table = FALSE) %>% 
  as_tibble()

df_shops <- data.table::fread("data/input/shops.csv",
                              data.table = FALSE,
                              encoding = "UTF-8") %>% 
  # mutate(shop_name = enc2utf8(shop_name)) %>% 
  as_tibble()

# -----------------------------------------------------------------------------
# Data fields

# ID - an Id that represents a (Shop, Item) tuple within the test set
# shop_id - unique identifier of a shop
# item_id - unique identifier of a product
# item_category_id - unique identifier of item category
# item_cnt_day - number of products sold. You are predicting a monthly amount of this measure
# item_price - current price of an item
# date - date in format dd/mm/yyyy
# item_name - name of item
# shop_name - name of shop
# item_category_name - name of item category