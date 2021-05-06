df_all <- bind_rows(df_train, df_test)

df_month <- df_all %>% 
  group_by(m_nr, shop_id, item_id) %>% 
  summarise(
    dates = n_distinct(date),
    item_price = mean(item_price),
    item_cnt_day = sum(item_cnt_day),
    shop_id = unique(shop_id)
  ) %>% 
  ungroup()

df_month2 <- crossing(
  m_nr = df_all$m_nr, 
  item_id = df_all$item_id,
  shop_id = df_all$shop_id
)

df_month <- df_month2 %>% 
  left_join(df_month, by = c("m_nr", "item_id", "shop_id")) 

df_month <- df_month %>% 
  map_df(replace_na, 0)

df_month <- df_month %>% 
  mutate(item_price = case_when(
    m_nr == 35 ~ NA_real_,
    TRUE ~ item_price
  )) %>% 
  mutate(item_cnt_day = case_when(
    m_nr == 35 ~ NA_real_,
    TRUE ~ item_cnt_day
  ))

df_month <- df_month %>% 
  mutate(dates = case_when(
    m_nr == 35 ~ NA_real_,
    TRUE ~ dates
  ))
