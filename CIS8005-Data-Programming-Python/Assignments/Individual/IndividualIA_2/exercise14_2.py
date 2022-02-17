# Name: BHAVIN PATEL
# Email: bpatel97@student.gsu.edu

numbers = input("Enter the numbers: ").split()
dict_numbers = {}
maxcount = 0
for x in numbers:
    if x not in dict_numbers.keys():
        dict_numbers[x] = numbers.count(x)
        if dict_numbers[x] > maxcount:
            maxcount = dict_numbers[x]
print("Numbers with most occurrences are: ")
for x in dict_numbers.keys():
    if dict_numbers[x] == maxcount:
        print(x, end=" ")
print(f"\nThey appear {maxcount} times")