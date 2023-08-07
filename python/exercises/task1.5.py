#!/usr/bin/env python3.6
import argparse

# mem: total used, free
# cpu info: model, core numbers, speed
# current user
# system load avg
# ip address
# -d for distro, -m for mem, -c for cpu, -u for user info, -l for load avera#ge, -i for ip address
def cli():
    parser = argparse.ArgumentParser(
            prog='PC Info',
            description='Based on flags, program will provide you with specific info about your PC',
            epilog='Have fun')
    parser.add_argument('-d', dest='d', action='store_true')
    parser.add_argument('-m', dest='m', action='store_true')
    parser.add_argument('-c', dest='c', action='store_true')
    parser.add_argument('-u', dest='u', action='store_true')
    parser.add_argument('-l', dest='l', action='store_true')
    parser.add_argument('-i', dest='i', action='store_true')
    args = parser.parse_known_args()
    dic = "dmculi"
    for char in dic:
        if char in args:
            print(f'{char}')

cli()
