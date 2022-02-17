# Name: BHAVIN PATEL
# Email: bpatel97@student.gsu.edu

exrate = eval(input("Enter the Exchange Rate from Dollars to RMB:"))
conversion = eval(input("Enter 0 to convert Dollars to RMB and 1 Vice Versa: "))
if (conversion == 0):
    dollar = eval(input("Enter the Dollar amount: "))
    rmb = (dollar * exrate * 100) / 100.0
    print("$" + str(dollar) + " is " + str(rmb) + " yuan")
elif (conversion == 1):
    rmb = eval(input("Enter the RMB amount:"))
    dollar = (rmb/exrate * 100) / 100.0
    print(rmb + " yuan is $" + dollar)
else:			
    print("Incorrect input!")