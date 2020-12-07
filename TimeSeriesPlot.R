rm(list=ls())

library(tidyr)
library(ggplot2)
library(dplyr)
dat <- read.csv("all_summarised_data.csv",header = T)

#extract useful information from those summarised data
dat$transactions_per_block <- round(dat$num_trans / dat$num_blocks,digits = 2)
dat$transacted_per_block <- round(dat$total_trans_amt / dat$num_blocks,digits = 2)
dat$blocks_per_day <- round(dat$num_blocks / dat$days_in_data,digits = 2)
dat$minutes_per_block<- round(dat$days_in_data*24*60 / dat$num_blocks,digits = 2)

#Draw time series plot based on the information with respect to time
#Plot for transactions_per_block
a <- ggplot(dat, aes(x=start_date, y=transactions_per_block, group = 1)) +
  geom_line() + 
  xlab("")
a
#Plot for transacted_per_block
b <- ggplot(dat, aes(x=start_date, y=transacted_per_block, group = 1)) +
  geom_line() + 
  xlab("")
b
#Plot for blocks_per_day
c <- ggplot(dat, aes(x=start_date, y=blocks_per_day, group = 1)) +
  geom_line() + 
  xlab("")
c
#Plot for minutes_per_block
d <- ggplot(dat, aes(x=start_date, y=minutes_per_block, group = 1)) +
  geom_line() + 
  xlab("")
d
