# Name: BHAVIN PATEL
# Email: bpatel97@student.gsu.edu

def sumMajorDiagonal(m):
    sum = 0
    for i in range(len(m)):
        sum += m[i][i]
    return sum


m = []
for i in range(4):
    row = input("Enter 4x4 Matrix " + str(i + 1) + ": ").split()
    m.append([float(x) for x in row])

print("Sum of the elements on major diagonal are:", sumMajorDiagonal(m))