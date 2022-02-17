# Name: BHAVIN PATEL
# Email: bpatel97@student.gsu.edu

import os.path
import sys
def main():
    keywords = {"and": 0, "as": 0, "assert": 0, "break": 0, "class": 0,
                "continue": 0, "def": 0, "del": 0, "elif": 0, "else": 0,
                "except": 0, "False": 0, "finally": 0, "for": 0, "from": 0,
                "global": 0, "if": 0, "import": 0, "in": 0, "is": 0, "lambda": 0,
                "None": 0, "nonlocal": 0, "not": 0, "or": 0, "pass": 0, "raise": 0,
                "return": 0, "True": 0, "try": 0, "while": 0, "with": 0, "yield": 0}
    filename = input("Enter the filename: ").strip()
    if not os.path.isfile(filename):
        print("File", filename, "does not exist")
        sys.exit()
    readfile = open(filename, "r")
    text = readfile.readlines()
    for line in text:
        for word in line.split():
            if word in keywords:
                keywords[word] += 1
    for itm in keywords:
        print(itm, ":", keywords[itm])
main()