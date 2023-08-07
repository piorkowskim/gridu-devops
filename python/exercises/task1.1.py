#!/usr/bin/env python3.6

import sys

def get_ext(path):
    try:
        base, ext = path.rsplit(".", 1)
    except ValueError:
        print("File name doesn't contain any extensions")
        sys.exit(1)
    return ext


path = input("Input a path: ")
extension = get_ext(path)
print(f'The extension is: {extension}')
