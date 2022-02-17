# Name: BHAVIN PATEL
# Email: bpatel97@student.gsu.edu

def indexOfSmallestElement(lst):
    small = float("inf")
    smallInd = 0
    for x in range(len(lst)):
        if lst[x] < small:
            small = lst[x]
            smallInd = x
    return smallInd


print(indexOfSmallestElement([10,5,7,9,3,1]))