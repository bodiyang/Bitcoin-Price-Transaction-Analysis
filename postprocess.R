# Perform simply summations for BTC data

rm(list = ls())

library(tidyverse)
library(lubridate)




all_data_raw = read_csv('./all_summarised_data.csv',col_names=TRUE)%>%
	filter(is.numeric(num_blocks))

write_csv(all_data_raw,"./all_data_raw.csv")

all_csvs <- all_data_raw %>%
	summarise(
	total_blocks = sum(num_blocks),
	total_trans = sum(num_trans),
	total_amt_transacted = sum(total_trans_amt),
	total_days_in_data = sum(days_in_data)
	) %>%
	mutate(
	trans_per_block = total_trans/total_blocks,
	amt_trans_per_block = total_amt_transacted/total_blocks,
	days_per_block = total_days_in_data/total_blocks
	)

by_csvs <- all_data_raw %>%
	mutate(
	trans_per_block = num_trans/num_blocks,
	amt_trans_per_block = total_trans_amt/num_blocks,
	days_per_block = days_in_data/num_blocks
	)






write_csv(by_csvs,"./output_bycsv.csv")
write_csv(all_csvs,"./output_allcsv.csv")



