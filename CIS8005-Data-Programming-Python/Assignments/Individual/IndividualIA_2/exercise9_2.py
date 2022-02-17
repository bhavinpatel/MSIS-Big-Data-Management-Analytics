# Name: BHAVIN PATEL
# Email: bpatel97@student.gsu.edu

class Stock:
    def __init__(self, symbol, name, previousClosingPrice, currentPrice):
        self.__symbol = symbol
        self.__name = name
        self.__previousClosingPrice = previousClosingPrice
        self.__currentPrice = currentPrice

    def getStockName(self):
        return self.__name
    def getStockSymbol(self):
        return self.__symbol
    def getPreviousStockPrice(self):
        return self.__previousClosingPrice
    def setPreviousStockPrice(self, previousClosingPrice):
        self.__previousClosingPrice = previousClosingPrice
    def getStockCurrentPrice(self):
        return self.__currentPrice
    def setStockCurrentPrice(self, currentPrice):
        self.__currentPrice = currentPrice

stock = Stock('INTC', 'Intel corporation', 20.5, 20.35)
previousPrice = stock.getPreviousStockPrice()
currentPrice = stock.getStockCurrentPrice()
change = format((currentPrice - previousPrice) * 100 / previousPrice, "5.2f") + "%"
print("Stock Name:", stock.getStockName(), "\nChanged price Percentage=", change)