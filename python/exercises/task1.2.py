#!/usr/bin/env python3.6

def remove_dups(dups):
    unique = sorted(list(set(dups)))
    return (unique[0], unique[-1])

random_integers = [12, 45, 7, 23, 91, 34, 18, 56, 72, 9, 63, 27, 84, 39, 50]
print(remove_dups(random_integers))
