# Name: BHAVIN PATEL
# Email: bpatel97@student.gsu.edu

n = 1000
add = 1 / 3
while n <= 10000:
    for i in range(n):
        pi = (((-1) ** (i + 1)) / (2*i - 1))
    print("Pie value for", n, "is", pi)
    n += 1000
    