# Perform simply summations for BTC data

rm(list = ls())

library(tidyverse)
library(lubridate)


all_data_raw = read_csv('./all.csv')


all_data <- all_data_raw %>% 
  mutate(
    trans_num = as.numeric(str_extract(Sum,"[0-9]+\\.?[0-9]*")),
    block_date = as.Date(Time),
    block_hour = hour(Time),
    block_minute = minute(Time),
    block_second = second(Time)
    ) %>% 
  group_by(Height) %>% 
  mutate(
    trans_per_block = n(),
    total_btc_per_block = sum(trans_num)
  ) %>% 
  ungroup() %>% 
  group_by(block_date) %>% 
  mutate(
    trans_per_day = n(),
    total_btc_per_day = sum(trans_num)
  ) %>% 
  ungroup()


time_since_last_block <-  all_data %>% 
  distinct(Height,.keep_all = T) %>% 
  select(Height,Time) %>% 
  arrange(Height) %>% 
  mutate(
    time_since_last_block = Time - lag(Time),
    last_block_sequential = ifelse(lag(Height)==Height-1,1,0)
  ) %>% 
  ungroup()







export_data <- all_data %>% 
  left_join(time_since_last_block %>% select(Height,time_since_last_block,last_block_sequential))



write_csv(export_data,"./summarised_data.csv")



