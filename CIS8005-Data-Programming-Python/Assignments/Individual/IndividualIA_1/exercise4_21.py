# Name: BHAVIN PATEL
# Email: bpatel97@student.gsu.edu

name = input("Enter employee's name:")
hours = eval(input("Enter number of hours worked:"))
hourRate = eval(input("Enter the hourly pay rate:"))
fedRate = eval(input('Enter federal tax withholding rate:'))
stateRate = eval(input('Enter state tax withholding rate:'))

print("Employee name:", name, '\n'
    "Hours Worked:", hours, '\n'
    "Pay Rate: $",hourRate, "\n"
    "Gross Pay: $",hours * hourRate, "\n"
    'Deductions:\n'
    "\t Federal Withholding (20.0%): $",(fedRate) * (hours * hourRate), '\n'
    "\t State Withholding (9.0%): $", stateRate * (hours * hourRate), '\n'
    "\t Total Deduction: $",((fedRate) * (hours * hourRate)) + (stateRate * (hours * hourRate)), '\n'
    "Net pay: $",(hours * hourRate) - (((fedRate) * (hours * hourRate)) + (stateRate * (hours * hourRate))))
