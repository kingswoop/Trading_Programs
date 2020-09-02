


# Load required packages.
library(janitor)
library(lubridate)
library(hms)
library(tidyr)
library(stringr)
library(readr)
library(openxlsx)
library(forcats)
library(RcppRoll)
library(dplyr)
library(tibble)
library(exploratory)
library(sentimentr)

# Set OAuth token. # Not my details, found online
exploratory::setTokenInfo("twitter", as.environment(list(user_id = "3039914070", screen_name = "Axe_Why", oauth_token = "3039914070-PeE1I4paM8Y7OWLAzfLq6lJnIy8if2Boe6ir4gQ", oauth_token_secret = "jfpEjEA17jFqXY16cyDQsNjWI07pJDnXbsCrzD8wf1f3h", consumer_sc = "wqP7VhX5yDEGzLL3eHSbT2wDlJvs4OitruIkd18CQZGzsySFuX")))


# Fetch Twitter Data
## Docs https://docs.exploratory.io/data_import/user-defined-plugin#create-data-source-extension-definition-file
data <- exploratory::select_columns(exploratory::clean_data_frame(exploratory::getTwitter(searchString = '#atvi', n = 20000, lang = '', lastNDays = 20, tokenFileId = '', includeRts = FALSE, withSentiment = TRUE)),"created_at","text","sentiment") %>% readr::type_convert() %>%
	#Remove where Sentiment is 0, this is because nothing that will affect the model is contained e.g. Dummy articles
  	filter(sentiment != 0) %>%
  	mutate(date = parse_character(created_at)) %>%
  	select(date, everything()) %>%
  	separate(date, into = c("date_1", "date"), sep = "\\s+", convert = TRUE) %>%
  	select(-date) %>%
  	rename(date = date_1) %>%
  	select(-created_at)

print (data)
write.csv(data, "twitter.csv", fileEncoding="UTF-8")

# Get stock price from date. tq_get(stockticket, get=getfunction, from=daterange)
#stockpull <- tidyquant::tq_get("AAPL", get = "stock.prices", from = "2006-01-01")
