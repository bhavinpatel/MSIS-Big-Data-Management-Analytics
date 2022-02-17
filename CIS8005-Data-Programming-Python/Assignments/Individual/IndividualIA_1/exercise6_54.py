# Name: BHAVIN PATEL
# Email: bpatel97@student.gsu.edu

def countLetters():
    s = input("Input a string: ")
    l=0
    for c in s:
        if c.isalpha():
            l=l+1
        else:
            pass
    print("Number of Letters are: ", l)
print(countLetters())