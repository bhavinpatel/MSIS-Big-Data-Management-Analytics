# Name: BHAVIN PATEL
# Email: bpatel97@student.gsu.edu

def isSorted(lst):
    for i in range(len(lst)-1):
        if lst[i] > lst[i+1]:
            return False
    return True

def checkSorted():
    list1 = eval(input("Enter List of Numbers: "))
    check = isSorted(list1)
    if(check):
        print("This List is Sorted!")
    else:
        print("This List is Not Sorted!")

checkSorted()