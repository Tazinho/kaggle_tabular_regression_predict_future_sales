df_month <- df_all %>%
  group_by(year, month, shop_id, item_id) %>% 
  summarise(item_price = mean(item_price),
            item_cnt_day = sum(item_cnt_day)) %>% 
  ungroup()