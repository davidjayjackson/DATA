# Import John Hopkins COVID-19 Data
# 
# Create three (3) data frames
# 1. Whole world
# 2. World minus the US
# 3. US only
#
rm(list=ls())
JH <- read.csv("../DATA/JHUDATA.csv")
JH$date <- as.Date(JH$date)
summary(JH)
str(JH) 
#
NOUS <- subset(JH,country !="US")
summary(NOUS)
US <- subset(JH,country=="US")
summary(US)

# World World
# 
plot(JH$date,JH$confirmed,typ="l", main="World Cumulative Cases")
plot(JH$date,JH$deaths,typ="l",main="World Cumulative Deaths ")
# 
# World Minus the US
#
plot(NOUS$date,NOUS$confirmed,type="l",main="World minus the US Cumulative Cases ")
plot(NOUS$date,NOUS$deaths,type="l",main="World minus the US Cumulative Deaths ")
#
# US Only 
#
plot(US$date,US$confirmed,type="l",main="The US Cumulative Cases ")
plot(US$date,US$deaths,type="l",main="The US Cumulative Deaths ")
#
# Calculate Daily Cumulative Totals CASES for Whole World.
# 
daily_cases <- aggregate(x=JH$confirmed,by=list(JH$date),FUN=sum)
plot(daily_cases$Group.1,daily_cases$x,type="l")
#
# Calculate Daily Cumulative Totals Deaths for Whole World.
# 
daily_deaths <- aggregate(x=JH$deaths,by=list(JH$date),FUN=sum)
plot(daily_cases$Group.1,daily_deaths$x,type="l")
#
## 
# World Minus The US
#
# Calculate Daily Cumulative Totals CASES for Whole World.
# 
nous_cases<- aggregate(x=NOUS$confirmed,by=list(NOUS$date),FUN=sum)
plot(nous_cases$Group.1,nous_cases$x,type="l")
#
# Calculate Daily Cumulative Totals Deaths for Whole World.
#
nous_cases <- aggregate(x=NOUS$confirmed,by=list(NOUS$date),FUN=sum)
plot(nous_cases$Group.1,nous_deaths$x,type="l")
#
##
# Calculate Daily Cumulative Totals Deaths for Whole World.
#
nous_deaths <- aggregate(x=NOUS$deaths,by=list(NOUS$date),FUN=sum)
plot(nous_deaths$Group.1,nous_deaths$x,type="l")
#
##