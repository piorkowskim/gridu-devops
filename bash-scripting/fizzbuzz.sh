#!/bin/bash

# Basic fizzbuzz script, not much to explain
for ((i = 1; i <= 100; i++)); do
	if   ! (($i % 15)) ; then
		echo "FizzBuzz"
	elif ! (($i % 5)); then
		echo "Buzz"
	elif ! (($i % 3)); then
		echo "Fizz"
	else
		echo $i
	fi
done
