# Name: BHAVIN PATEL
# Email: bpatel97@student.gsu.edu

import random

my_list = list()
for i in range (1000):
    my_list.append(random.randint(0,9))
my_counts = list()
for i in range(10):
    my_counts.append(my_list.count(my_list[i]))

for i in range(10):
    print(i, ":", my_counts[i], "times")
