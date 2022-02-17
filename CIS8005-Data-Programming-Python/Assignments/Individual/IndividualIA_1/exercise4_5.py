# Name: BHAVIN PATEL
# Email: bpatel97@student.gsu.edu

import math
sides = int(input("Enter the number of sides: "))
length = float(input("Enter the length of a side: "))
area = (sides * length**2) / (4 * math.tan(math.pi/sides))
print("The area of regular polygon is: " + str(area))
