# Name: BHAVIN PATEL
# Email: bpatel97@student.gsu.edu

def sumColumn(m, columnIndex):
    sum = 0
    for row in range(len(m)):
        sum += m[row][columnIndex]
    return sum

m = []

for i in range(3):
    row = input("Enter 3x4 Matrix" + str(i)+": ").split()
    m.append([float(x) for x in row])

for i in range(4):
    s = sumColumn(m, i)
    print("Sum of elements in Column", i, 'are', s)