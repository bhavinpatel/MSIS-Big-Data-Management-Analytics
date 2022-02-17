# Name: BHAVIN PATEL
# Email: bpatel97@student.gsu.edu

def getNumber(c):
    if(c=='a' or c== 'b' or c=='c' or c=='A' or c == 'B' or c == 'C'):
        return (2)
    elif(c=='d' or c== 'e' or c=='f' or c=='D' or c == 'E' or c == 'F'):
        return (3)
    elif(c=='g' or c== 'h' or c=='i' or c=='G' or c == 'H' or c == 'I'):
        return (4)
    elif(c=='j' or c== 'k' or c=='l' or c=='J' or c == 'K' or c == 'L'):
        return (5)
    elif(c=='m' or c== 'n' or c=='o' or c=='M' or c == 'N' or c == 'O'):
        return (6)
    elif(c=='p' or c== 'q' or c=='r' or c=='s' or c=='P' or c == 'Q' or c == 'R' or c == 'S'):
        return (7)
    elif(c=='t' or c== 'u' or c=='v' or c=='T' or c == 'U' or c == 'V'):
        return (8)
    elif(c=='w' or c== 'x' or c=='y' or c=='z' or c=='W' or c == 'X' or c == 'Y' or c == 'Z'):
        return (9)
    else:
        return (0)

string = input("Please enter any string to convert! ") 
length = len(string) 
for i in range(length):
    c = string[i]
    k = getNumber(c)
    if(k==0):
        print (c,end="")
    else:
        print (k,end="") 

