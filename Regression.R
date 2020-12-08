#This script will build the linear regression of the daily total bitcoin transaction and the daily price of the bitcoin

rm(list=ls())

library(tidyverse)
library(lubridate)

args = (commandArgs(trailingOnly=TRUE))
csv_name = as.character(args[1])

csv_save_name = str_replace(csv_name,"-","to")


numbers = str_replace(csv_save_name,".csv","")


#read and clean price data: price
price_dat <- read.csv("bitcoin_price_data.csv", header = FALSE)

temp_price <- price_dat[-c(1),]
price_temp <- data.frame(date_temp=temp_price$V1, price=temp_price$V2)
price <- data.frame(date=price_temp$date_temp, price=price_temp$price)

#write.csv(price,"price_data.csv")

#read and clean transaction data: trans_data
read_trdata <- read.csv(paste0("per_day_",csv_save_name), header = FALSE)
temp_trans_data <- data.frame(date=read_trdata$V7, total_btc_per_day=read_trdata$V14)
trans_data <- temp_trans_data[-c(1),]

#merged data, containing price and transaction per day
trans_price_raw <- merge(price, trans_data, by.x = "date", by.y = "date", all = TRUE, na.rm = TRUE)
#trans_price_raw <- price %>% 
#	left_join(trans_data, by = "date")


trans_price <- na.omit(trans_price_raw)

#rough plot of Price ~ Transaction number
#scatter.smooth(x=trans_price$price, y=trans_price$total_btc_per_day, main="Price ~ Transaction number")


temp <- trans_price %>%
	mutate(
	num_btc = as.numeric(total_btc_per_day),
	num_price = as.numeric(gsub(",","",price))
	)


#write.csv(trans_price,paste0("transprice_",numbers,".csv"))
#linear regression
model=lm(formula = num_btc ~ num_price, data = temp)
summary(model)
anova(model)


output <- data.frame(index=numbers, p_value=anova(model)$Pr[1], Residuals_Sum_Sq=anova(model)$Sum[2], F_value=anova(model)$F[1])

#What to do: write the output whcih we may need
write.csv(output, paste0("regressions_",numbers,".csv"))


