#!/bin/bash
# script to calculate fibonacci numbers

# function to calculate fibonacci
calc_fib() {
	local n=$1
	local a=0
	local b=1
		for ((i=2; i<=n; i++)); do
			result=$((a + b))
			a=$b
			b=$result
		done
	echo $result
}
# test if an argument is a non-negative int
if ! [[ "$1" =~ ^[0-9]+$ ]]; then
	echo "Error: Argument must be a non-negative int"
	exit 1

# validations of argument
elif [ $# -ne 1 ]; then
	echo "Usage: $0 <n>"
	exit 1
elif [ $1 -eq 0 ] || [ $1 -eq 1 ]; then
	echo $1
	exit 0
else
	res=$(calc_fib $1)
echo $res
fi

