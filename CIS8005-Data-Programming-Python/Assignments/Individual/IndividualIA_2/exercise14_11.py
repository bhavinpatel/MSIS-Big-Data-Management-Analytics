# Name: BHAVIN PATEL
# Email: bpatel97@student.gsu.edu

vowels = {'a', 'e', 'i', 'o', 'u'}
count_vowels = 0
count_consonants = 0
file = open(input("Enter Filename: "))
lines = file.readlines()
for line in lines:
    for word in line.split():
        for c in word.lower():
            if c in vowels:
                count_vowels += 1
            else:
                count_consonants += 1

print("Total number of vowels =", count_vowels)
print("Total number of consonants =", count_consonants)