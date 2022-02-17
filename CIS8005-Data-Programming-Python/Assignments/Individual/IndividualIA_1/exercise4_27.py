# Name: BHAVIN PATEL
# Email: bpatel97@student.gsu.edu

letter = input("Enter a lowercase or uppercase letter: ")
character = letter[0]
character = character.upper();
number = 0
if (character.isalpha()):
    if (character >= 'W'):
        number = 9
    elif (character >= 'T'):
        number = 8
    elif (character >= 'P'):
        number = 7
    elif (character >= 'M'):
        number = 6
    elif (character >= 'J'):
        number = 5
    elif (character >= 'G'):
        number = 4
    elif (character >= 'D'):
        number = 3
    elif (character >= 'A'):
        number = 2
    print("The corresponding number is " + str(number))
else:
    print(character + " is an invalid input")
	