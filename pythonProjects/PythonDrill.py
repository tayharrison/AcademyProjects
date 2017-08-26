# -*- coding: cp1252 -*-
#Python :   2.7.13
#
#Author:    Taylor Harrison
#
#Python Drill

#1. Assign an integer to a variable
varInt = 1

#2. Assign a string to a variable
varString = "This is a string."

#3. Assign a float to a variable
varFloat = 8.0

#4. Use the print function and .format() notation to print out the variable you assigned
print varString.capitalize()

#5. Use each of these operators +, - , * , / , +=, ­= , %
x = 8
y = 10
x + y # addition
x - y # subtraction
x * y # multiplication
x / y # division
x += y # x = x + y
x -= y # x = x - y
x % y # modulus (remainder of x divded by y)

#6. Use of logical operators: and, or, not
x and y; #is True if both x and y are true
x or y; #is True if both x and y are true
#x not y; #if a condition is True then logical not operator will make false

#7. Use of conditional statements: if, elif, else
x = 1
if x == 10:
    print 'x = 10'
    
elif x == 9:
    print 'x = 9'
    
else:
    print 'x does not equal 9 or 10'

#8. Use of a while loop
x = 0;
while (x < 5):
    print (x)
    x += 1

#9. Use of a for loop
for counter in range(0,5):
    print counter

#10. Create a list and iterate through that list using a for loop to print each item out on a new line
fruit_list=["apple",
            "banana",
            "peach",
            "pear"]
for fruit in fruit_list:
    print fruit
    
#11. Create a tuple and iterate through it using a for loop to print each item out on a new line
for name in ('John','Kate'):
    print("Hello",name)  

#12. Define a function that returns a string variable
def happyBirthday():
    print("Happy Birthday to you!")

#13. Call the function you defined above and print the result to the shell
happyBirthday()
