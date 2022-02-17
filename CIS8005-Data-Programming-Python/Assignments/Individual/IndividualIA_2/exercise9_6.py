# Name: BHAVIN PATEL
# Email: bpatel97@student.gsu.edu

import math

class QuadraticEquation:
    def __init__(self, a, b, c):
        self.__a = a
        self.__b = b
        self.__c = c

    def getA(self):
        return self.__a
    def getB(self):
        return self.__b
    def getC(self):
        return self.__c
    def getDiscriminant(self):
        return self.__b * self.__b - 4 * self.__a * self.__c
    def getRoot1(self):
        if self.getDiscriminant() < 0:
            return 0
        else:
            return (-self.__b + self.getDiscriminant()) / (2 * self.__a)
    def getRoot2(self):
        if self.getDiscriminant() < 0:
            return 0
        else:
            return (-self.__b - self.getDiscriminant()) / (2 * self.__a)

a, b, c = eval(input("Enter a, b, c: "))
eq = QuadraticEquation(a, b, c)
disc = eq.getDiscriminant()
if disc < 0:
    print("The equation has no roots")
elif disc == 0:
    print("The root is", eq.getRoot1())
else:
    print("The roots are", eq.getRoot1(), "and", eq.getRoot2())