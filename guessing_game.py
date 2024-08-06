import random

guess = None
picked_num = None

guess = 1
print("I will think of a number between 1 and 10 and you should guess it.")
picked_num = random.randint(1, 10)
while guess != picked_num:
         guess = int(input("guess what number I just picked? "))
print("Congrats, you just guessed my number!")