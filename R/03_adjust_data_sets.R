df_train <- df_train %>% 
  left_join(df_items, by = c("item_id")) %>% 
  left_join(df_item_categories, by = c("item_category_id")) %>% 
  left_join(df_shops, by = c("shop_id"))

# date, shop_id, item_id, item_price, item_cnt_day
# item_name, item_category_id, item_category_name,
# shop_name

df_test <- df_test %>%
  mutate(item_cnt_day = NA_real_) %>% 
  left_join(df_items, by = "item_id") %>% 
  left_join(df_item_categories, by = "item_category_id") %>% 
  left_join(df_shops, by = "shop_id") %>% 
  mutate(item_price = NA_real_)

df_date <- tibble(
  date = seq(ymd('2015-11-01'),ymd('2015-12-01')-1, by = '1 day')
)

df_test <- df_date %>% left_join(df_test, by = character())
df_test <- df_test[names(df_train)]

df_train <- df_train %>% mutate(set = "train")
df_test  <- df_test  %>% mutate(set = "test")

df_all <- bind_rows(df_train, df_test)

df_all <- df_all %>% 
  mutate(
    year = year(date),
    month = month(date),
    day = day(date),
    wday = wday(date)
  )