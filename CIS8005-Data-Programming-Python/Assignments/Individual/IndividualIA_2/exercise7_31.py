# Name: BHAVIN PATEL
# Email: bpatel97@student.gsu.edu

def count(s):
    for a, b in sorted((c, s.count(c)) for c in set(s) if c.isdigit()):
        print("{} occurs {} times".format(a, b))

my_string = input("Enter any String: ")
count(my_string)