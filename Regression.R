#This script will build the linear regression of the daily total bitcoin transaction and the daily price of the bitcoin

rm(list=ls())

library(tidyr)

#read and clean price data: price
price_dat <- read.csv("Bitcoin Historical Data - Investing.com.csv", header = FALSE)
temp_price <- price_dat[-c(1),]
price_temp <- data.frame(date_temp=temp_price$V1, price=temp_price$V2)
price <- data.frame(date=price_temp$date_temp, price=price_temp$price)

#read and clean transaction data: trans_data
read_trdata <- read.csv("per_day_300001to310000.csv", header = FALSE)
temp_trans_data <- data.frame(date=read_trdata$V7, total_btc_per_day=read_trdata$V14)
trans_data <- temp_trans_data[-c(1),]

#merged data, containing price and transaction per day
trans_price_raw <- merge(price, trans_data, by.x = "date", by.y = "date", all = TRUE, na.rm = TRUE)
trans_price <- na.omit(trans_price_raw)

#rough plot of Price ~ Transaction number
scatter.smooth(x=trans_price$price, y=trans_price$total_btc_per_day, main="Price ~ Transaction number")

#linear regression
model=lm(formula = as.numeric(total_btc_per_day) ~ as.numeric(price), data = trans_price)
summary(model)
anova(model)

