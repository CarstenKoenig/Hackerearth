'''
# Combinatorics in python

please see the Haskell source for description and sensible code
had to do this because the problem does not allow any reasonable
language :(
'''

from math import factorial

def fact(n):
    return factorial(long(n))

def nrOfRearrangements(text):
    stext = list(text)
    stext.sort()
    total = fact(len(stext))
    count = 1
    curChar = '#'
    for c in stext:
        if curChar <> c:
            curChar = c
            total = total / fact(count)
            count = 1
        else:
            count = count + 1
    return total / fact(count)
            
def processCase(i):
    text = raw_input()
    print "Case " + str(i+1) + ": " + str(nrOfRearrangements(text))

count = raw_input()
for i in range(int(count)):
    processCase(i)

