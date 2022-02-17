# Name: BHAVIN PATEL
# Email: bpatel97@student.gsu.edu

kilogram = 1
print("Kilograms \t Pounds")
for kilogram in range(1, 200, 2):
    pounds = kilogram * 2.2
    print(str(format(kilogram, "<4.0f")) + str(format(pounds, "20.1f")))
    