# Name: BHAVIN PATEL
# Email: bpatel97@student.gsu.edu

def computeCommission(salesAmount):
    while salesAmount < 100000 :
        salesAmount += 5000
        if salesAmount > 10000.01 :
            commission = (salesAmount - 10000) * 0.12 + 5000 * 0.10 + 5000 * 0.08
        elif salesAmount > 5000.01 :
            commission = (salesAmount - 5000) * 0.10 + 5000 * 0.08
        else :
            commission = salesAmount * 0.08

        print("Sales Amount\t", "Commission")
        print(salesAmount, "\t", commission)

computeCommission(5000)