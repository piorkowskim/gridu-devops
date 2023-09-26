#!/usr/bin/env python3.6

import argparse
import platform
import psutil
import socket

def get_distro_info():
    return platform.dist()

def get_memory_info():
    virtual_memory = psutil.virtual_memory()
    return virtual_memory.total, virtual_memory.used, virtual_memory.free

def get_cpu_info():
    cpu_info = {}
    cpu_info['model'] = platform.processor()
    cpu_info['core_count'] = psutil.cpu_count(logical=False)
    cpu_info['speed'] = psutil.cpu_freq().current
    return cpu_info

def get_user_info():
    return psutil.users()[0].name

def get_load_average():
    return psutil.getloadavg()

def get_ip_address():
    return socket.gethostbyname(socket.gethostname())

# -d distro -m memory -c cpu -u userinfo -l loadavg -i ipaddress
def main():
    parser = argparse.ArgumentParser(description="Retrieve system information")
    parser.add_argument("-d", "--distro", action="store_true", help="Get distro info")
    parser.add_argument("-m", "--memory", action="store_true", help="Get memory info")
    parser.add_argument("-c", "--cpu", action="store_true", help="Get CPU info")
    parser.add_argument("-u", "--user", action="store_true", help="Get user info")
    parser.add_argument("-l", "--loadavg", action="store_true", help="Get load average")
    parser.add_argument("-i", "--ip", action="store_true", help="Get IP address")
    args = parser.parse_args()

    if args.distro:
        print(f"Distro Info: {get_distro_info()}\n")

    if args.memory:
        total, used, free = get_memory_info()
        print(f"Memory Info:")
        print(f"Total: {total} bytes")
        print(f"Used: {used} bytes")
        print(f"Free: {free} bytes\n")

    if args.cpu:
        cpu_info = get_cpu_info()
        print(f"CPU Info:")
        print(f"Model: {cpu_info['model']}")
        print(f"Core Count: {cpu_info['core_count']}")
        print(f"Speed: {cpu_info['speed']} MHz\n")

    if args.user:
        print(f"Current User: {get_user_info()}\n")

    if args.loadavg:
        load_avg = get_load_average()
        print(f"Load Average: {load_avg}\n")

    if args.ip:
        print(f"IP Address: {get_ip_address()}\n")


main()
