# Name: BHAVIN PATEL
# Email: bpatel97@student.gsu.edu

commissionPerYear = 30000
commissionPerMonth = commissionPerYear / 12
salesAmount = 0.01
commission = 0
while commission < commissionPerMonth :
    salesAmount += 0.01
    if salesAmount > 10000.01 :
        commission = (salesAmount - 10000) * 0.12 + 5000 * 0.10 + 5000 * 0.08
    elif salesAmount > 5000.01 :
        commission = (salesAmount - 5000) * 0.10 + 5000 * 0.08
    else :
        commission = salesAmount * 0.08

print("You need $" + format(salesAmount, "<.2f"),
      "monthly sales amount to make a commission of $30000 per year")