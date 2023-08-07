#!/usr/bin/env python3.6

def count(word):
    ans = {}
    for char in word:
        if char in ans:
            ans[char] += 1
        else:
            ans[char] = 1
    return ans

print(count("pythonnohtyppy"))
