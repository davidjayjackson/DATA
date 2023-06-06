library(RSQLite)
library(tidyverse)
library(tidytuesdayR)
library(janitor)

rm(list=ls())
db <- dbConnect(SQLite(), dbname="../DATA/tidytuesday.sqlite3")

## Import Tornado data from tidytuesday: 2023/2023-05-16
# tornados <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-05-16/tornados.csv')
## Convert date to text type

tornados$date <- as.character(tornados$date)
dbWriteTable(db,"tornados",tornados ,overwrite=TRUE)

## Import Central Park Squirrel Census 2023-05-24
squirrels <- read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-05-23/squirrel_data.csv')|>
  janitor::clean_names() |>
  rename(lon = x,lat = y)
squirrels$date <- as.character(squirrels$date)
squirrels$date <- mdy(squirrels$date)
squirrels$date <- as.character(squirrels$date)
dbWriteTable(db,"squirrels",squirrels ,overwrite=TRUE)

squirrels |> count(primary_fur_color) |> ggplot(aes(x=primary_fur_color,y=n)) + geom_col()

## Verified Oldest People May 30, 2023

tuesdata <- tidytuesdayR::tt_load('2023-05-30')
centenarians <- tuesdata$centenarians %>% clean_names()
centenarians$birth_date <- as.character(centenarians$birth_date)
centenarians$death_date <- as.character(centenarians$death_date)
dbWriteTable(db,"centenarians",centenarians ,overwrite=TRUE)
dbGetQuery(db, "SELECT count(*) FROM centenarians")

##  Our Word In Data Complete Energy Data set June 05, 2023

owid_energy <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-06-06/owid-energy.csv') %>% 
  clean_names() %>% 
  remove_empty(which = c("rows", "cols"))

dbWriteTable(db,"owid_energy",owid_energy,overwrite=TRUE)
dbGetQuery(db,"SELECT count(*) FROM owid_energy")
