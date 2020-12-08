# Perform simply summations for BTC data

rm(list = ls())

library(tidyverse)
library(lubridate)



args = (commandArgs(trailingOnly=TRUE))
csv_name = as.character(args[1])

csv_save_name = str_replace(csv_name,"-","to")        


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


per_day <- all_data %>%
distinct(block_date, .keep_all = TRUE)


export_data <- all_data %>%
	filter(trans_per_day>100) %>%
	mutate(
		start_date = min(block_date),
		end_date = max(block_date),
		min_block = min(Height),
		max_block = max(Height),
		days_in_data = end_date-start_date,
		total_trans_amt = sum(trans_num),
		num_trans = n(),
		csv_file = csv_save_name
	) %>%
	distinct(Height,.keep_all = TRUE) %>%
	mutate(num_blocks = n())%>%
	select(csv_file,num_trans,total_trans_amt,num_blocks,start_date,end_date,min_block,max_block,days_in_data) %>%
	distinct()


write_csv(export_data,paste0("./summarised_data_",csv_save_name))
write_csv(per_day, paste0("./per_day_",csv_save_name))


