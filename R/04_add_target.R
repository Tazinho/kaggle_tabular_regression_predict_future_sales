df_month <- df_month %>% arrange(shop_id, item_id, m_nr)

df_month <- df_month %>% 
  mutate(target = lead(item_cnt_day)) %>% 
  mutate(target = case_when(
    is.na(target) ~ NA_real_,
    target > 20 ~ 20,
    target <  0 ~ 0, 
    TRUE ~ target))

df_month <- df_month %>% 
  filter(m_nr != 35)

df_month <- df_month %>% 
  mutate(set = case_when(
    m_nr == 34 ~ "test",
    m_nr == 33 ~ "validation",
    m_nr <= 32 ~ "train"
  ))
