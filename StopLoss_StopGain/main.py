import yfinance as yf
import os 
import matplotlib
from csv import reader

### THIS IS JUST RELEVANT TO MY FILE STRUCTURE AS MY WATCHLIST IS IN THE PARENT DIRECTORY ###
# Current Path
path = os.getcwd()
# Get Parent Directory
parentdir = os.path.abspath(os.path.join(path, os.pardir))
print(parentdir)


##WATCHLIST FILE
fileToOpen = parentdir + "/" + "watchlist.csv"

def getyfinanceinfo(ticker):
    print(ticker)
    stock = yf.Ticker(ticker)
    # get stock info
    info = stock.info
    print(info)
    # get stock history
    stock_df = stock.history(period="max")
    print(stock_df)
    
    ##PLOT
    #stock_df['Close'].plot(title= ticker + " stock price")


# Iterate through Watchlist of tickers
with open(fileToOpen, 'r') as read_obj:
    # pass the file object to reader() to get the reader object
    tickerList = reader(read_obj)
    # Iterate over each row in the csv using reader object
    for ticker in tickerList:
        # row variable is a list that represents a row in csv
        getyfinanceinfo(str(ticker))
