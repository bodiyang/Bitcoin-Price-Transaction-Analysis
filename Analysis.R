#1.
dat <- read.csv("summarised_data.csv",header = T)
dat <- dat[order(dat$Time),]

average <- mean(dat$trans_num)
num_transaction_block <- tapply(dat$trans_per_block,dat$Height,mean)
num_quantity_block <- tapply(dat$total_btc_per_block,dat$Height,mean)

index_repeated_block<-c()
for(i in 2:dim(dat)[1]){
  if(dat$Height[i-1]!=dat$Height[i]|i==2){
    index_repeated_block[i]<-i
  }else{
    index_repeated_block[i]<-0
  }
}

index_repeated_block <- index_repeated_block[-which(index_repeated_block==0|is.na(index_repeated_block))]
index_repeated_block
date.dat <- data.frame(block = dat$Height[index_repeated_block], date=dat$block_date[index_repeated_block], hour=dat$block_hour[index_repeated_block], minute=dat$block_minute[index_repeated_block], second=dat$block_second[index_repeated_block])

diff.day<-c()
diff.hour<-c()
diff.min<-c()
diff.sec<-c()
for (i in 1:dim(date.dat)[1]-1){
  diff.day[i] <- as.Date(date.dat$date[i+1], format="%m/%d/%Y")-as.Date(date.dat$date[i], format="%m/%d/%Y")
}

for (i in 1:dim(date.dat)[1]-1){
  diff.hour[i] <- date.dat$hour[i+1]-date.dat$hour[i]
}

for (i in 1:dim(date.dat)[1]-1){
  diff.min[i] <- date.dat$minute[i+1]-date.dat$minute[i]
}

for (i in 1:dim(date.dat)[1]-1){
  diff.sec[i] <- date.dat$second[i+1]-date.dat$second[i]
}

for(i in 1:length(diff.day)){
  if(diff.sec[i]<0){
    diff.min[i] <- diff.min[i]-1
    diff.sec[i] <- diff.sec[i]+60
    if(diff.min[i]<0){
      diff.hour[i] <- diff.hour[i]-1
      diff.min[i] <- diff.min[i]+60
      if(diff.hour[i]<0){
        diff.day[i] <- diff.day[i]-1
        diff.hour[i] <- diff.hour[i]+24}
      else{
        diff.day[i] <- diff.day[i]
        diff.hour[i] <- diff.hour[i]
      }}
    else{
      diff.hour[i] <- diff.hour[i]
      diff.min[i] <- diff.min[i]
      if(diff.hour[i]<0){
        diff.day[i] <- diff.day[i]-1
        diff.hour[i] <- diff.hour[i]+24}
      else{
        diff.day[i] <- diff.day[i]
        diff.hour[i] <- diff.hour[i]
      }
    }}
  else{
    diff.min[i] <- diff.min[i]
    diff.sec[i] <- diff.sec[i]
    if(diff.min[i]<0){
      diff.hour[i] <- diff.hour[i]-1
      diff.min[i] <- diff.min[i]+60
      if(diff.hour[i]<0){
        diff.day[i] <- diff.day[i]-1
        diff.hour[i] <- diff.hour[i]+24}
      else{
        diff.day[i] <- diff.day[i]
        diff.hour[i] <- diff.hour[i]
      }}
    else{
      diff.hour[i] <- diff.hour[i]
      diff.min[i] <- diff.min[i]
      if(diff.hour[i]<0){
        diff.day[i] <- diff.day[i]-1
        diff.hour[i] <- diff.hour[i]+24}
      else{
        diff.day[i] <- diff.day[i]
        diff.hour[i] <- diff.hour[i]
      }
    }}
}

cbind(diff.day,diff.hour,diff.min,diff.sec)

#2.
v <- tapply(dat$trans_num,dat$Time,sum)
diff.v<-c()
for(i in 1:length(v)-1){
 diff.v[i] <- v[i+1]-v[i]
}

Q3 <- summary(diff.v)[5]
Q1 <- summary(diff.v)[2]
IQR <- Q3-Q1
I <- c(Q1-1.5*IQR,Q3+1.5*IQR)

index_steeps <- which(diff.v<I[1]|diff.v>I[2])
index_steeps
plot(v,type="l",xlab="time",ylab="amount of transacted bitcoin",main="")
