# Name: BHAVIN PATEL
# Email: bpatel97@student.gsu.edu

class Account:
    def __init__(self,id=0,balance=100,annualIntersetRate=0):
        self.__id = id
        self.__balance = balance
        self.__annualIntersetRate = annualIntersetRate

    def getId(self):
        return self.__id
    def getBalance(self):
        return self.__balance
    def getAnnualIntersetRate(self):
        return self.__annualIntersetRate
    def setId(self,id):
        self.__id = id
    def setBalance(self,balance):
        self.__balance = balance
    def setAnnualIntersetRate(self,annualIntersetRate):
        self.__annualIntersetRate = annualIntersetRate
    def getMonthlyInterestRate(self):
        return (self.__annualIntersetRate/ 12) /100
    def getMonthlyInterest(self):
        return self.__balance *self.getMonthlyInterestRate()
    def deposit(self,balance):
        self.__balance += balance
    def withdraw(self,amount):
        self.__balance -= amount

def main():
    acc = Account(1122, 20000, 4.5)
    acc.withdraw(2500)
    getAccountInfo(acc)
    print()
    acc.deposit(3000)
    getAccountInfo(acc)

def getAccountInfo(acc):
    id = acc.getId()
    bal = acc.getBalance()
    mir = acc.getMonthlyInterestRate()
    mi = acc.getMonthlyInterest()
    print("Account ID:", id, "\nBalance:", bal,
          "\nMonthly IR:", mir, "\nMonthly interest:", mi)
          
main()