# Name: BHAVIN PATEL
# Email: bpatel97@student.gsu.edu

string_input = input('Enter a string: ')
even_chars = []
odd_chars = []
for i in range(len(string_input)):
    if i % 2 == 0:
        even_chars.append(string_input[i])
    else:
        odd_chars.append(string_input[i])
print('The chaacters at Odd Positions are: {}'.format(odd_chars))
