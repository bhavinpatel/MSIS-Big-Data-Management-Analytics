# Name: BHAVIN PATEL
# Email: bpatel97@student.gsu.edu

def main():
    matrix = input("Enter Students Names and Scores: ").split()
    students = []
    for i in range(0,len(matrix),2):
        temp = []
        temp.append(float(matrix[i+1]))
        temp.append(matrix[i])
        students.append(temp)
        students.sort()
 
    for i in range(0,int(len(matrix)/2)):
        print(students[i][1]+ "   " +str(students[i][0]))
        
main()