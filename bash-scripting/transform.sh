#!/bin/bash
# 1 false 0 true
v=1
s=1
r=1
l=1
u=1
aword=""
bword=""
input=""
output=""

# self explanatory
print_usage(){
	echo "usage: $0 [-v, -s, -r, -l, -u] [-i <input_file] [-o <output_file]"
}

# convert case from lowercase to uppercase & vice versa
convert_case(){
	tr '[:upper:][:lower:]' '[:lower:][:upper:]' < "$input" > "$output"
}

# substitute aword with bword
sub(){
	sed "s/$aword/$bword/g" "$input" > "$output"
}

# reverse text
reverse(){
	rev "$input" > "$output"
}

# convert to lowercase
lower(){
	tr '[:upper:]' '[:lower:]' < "$input" > "$output"
}

# convert to uppercase
upper(){
	tr '[:lower:]' '[:upper:]' < "$input" > "$output"
}
# process cli arguments 
	while [[ $# -gt 0 ]]; do
	case "$1" in
		-v) v=0
		    shift ;;
		-s) s=0
		    shift
		    aword=$1
		    shift
		    bword=$1
		    shift ;;
		-r) r=0
		    shift ;;
		-l) l=0
		    shift ;;
		-u) u=0
		    shift ;;
		-i) shift
		    input=$1 
		    shift ;;
		-o) shift
		    output=$1
		    shift ;;
		 *) echo "Invalid option $1"
		    print_usage
		    exit 1 ;; 
	esac
	done
# main logic xd
if [[ v -eq 0 ]]; then
	convert_case
elif [[ s -eq 0 ]]; then
	sub
elif [[ r -eq 0 ]]; then
	reverse
elif [[ l -eq 0 ]]; then
	lower
elif [[ u -eq 0 ]]; then
	upper
else
	print_usage
fi
