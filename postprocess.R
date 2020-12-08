# Perform simply summations for BTC data

rm(list = ls())

library(tidyverse)
library(lubridate)




all_data_raw = read_csv('./all_summarised_data.csv',col_names=TRUE)%>%
	filter(is.numeric(num_blocks))

all_per_day_raw = read_csv('./all_per_day_data.csv',col_names=TRUE)



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


per_day_export <- all_per_day_raw %>%
	group_by(block_date) %>%
	summarise(
		daily_trans = sum(trans_per_day),
		daily_btc = sum(total_btc_per_day)
		) %>%
	ungroup()


# Calculate Correlations
per_day_summ <- per_day_export
price_raw <- read.csv("./bitcoin_price_data.csv",
                      col.names = c("Date","price","open","high","low","vol","change"))

price <- price_raw %>%
  mutate(
    date = as.Date(Date),
    price = as.numeric(gsub(",","",price))
  ) %>%
  select(
    date,price
  )


per_day_summ <- per_day_summ %>%
  mutate(
    block_date = as.Date(block_date),
    lag_2week = block_date - 14
  ) %>%
  left_join(price,by = c("block_date"="date"))



run_data <- per_day_summ %>%
  filter(block_date>=as.Date("2012-01-01"))


results_data <- setNames(data.frame(matrix(ncol = 3, nrow = 0)), c("end_date", "price_trans_cor", "price_btc_cor"))


for (date in run_data$block_date){

  temp <- per_day_summ %>%
    filter(block_date<=date &
             block_date>=(date-14)) %>%
    summarise(
      end_date = date,
      price_trans_cor = cor(price,daily_trans),
      price_btc_cor = cor(price,daily_btc)
    ) %>% ungroup()

  results_data <- results_data %>%
    bind_rows(temp)

}

results_data <- results_data %>%
  ungroup() %>%
  mutate(
    date = as.Date(end_date,origin = "1970-01-01")
  ) %>%
  select(date,price_trans_cor,price_btc_cor)




write_csv(results_data,"./correlations.csv")
 

write_csv(by_csvs,"./output_bycsv.csv")
write_csv(all_csvs,"./output_allcsv.csv")

write_csv(per_day_export,"./per_day_summary.csv")

