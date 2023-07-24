#!/bin/bash

valid_o(){
char=$1
is_valid=1

case "$char" in
	+ | - | % | \*) is_valid=0 ;;
esac
if [ "$is_valid" -ne 0 ]; then
	echo "Error: Invalid character. Valid ones are: +, -, %, *"
	exit 1
fi
}
d=0

while getopts "o:n:d:" opt; do
	case $opt in
		o) echo valid_o $OPTARG; option=$OPTARG ;;
		n) numbers+=($OPTARG) ;;
		d) d=1 ;;
	esac
done
shift $((OPTIND -1))

echo "option: " $option "d: " $d
for val in "${numbers[@]}"; do
	echo " - $val"
done
