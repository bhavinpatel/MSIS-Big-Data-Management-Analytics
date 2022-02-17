# Name: BHAVIN PATEL
# Email: bpatel97@student.gsu.edu

a=eval(input("Enter an integer: "))
if a % 5 == 0 and a % 6 == 0:
    print("Is divisible by 5 and 6!")
else:
    print("Is not divisible by 5 and 6!")
if a % 5 == 0 or a % 6 == 0:
    print("Is divisible by 5 or 6!")
else:
    print("Is not divisible by 5 or 6!")
if (a % 5 == 0 or a % 6 == 0) and not (a % 5 == 0 and a % 6 == 0):
    print("Is divisible by 5 or 6, but not both!")
else:
    print("Is not divisible by 5 or 6, or both!")
