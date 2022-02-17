# Name: BHAVIN PATEL
# Email: bpatel97@student.gsu.edu

def eliminateDuplicates(lst):
    final_list = []
    for num in lst:
        if num not in final_list:
            final_list.append(num)
    return final_list
     
print(eliminateDuplicates([2, 4, 10, 20, 5, 2, 20, 4]))