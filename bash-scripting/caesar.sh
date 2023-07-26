#!/bin/bash
a=abcdefghijklmnopqrstuvwxyz
b=ABCDEFGHIJKLMNOPQRSTUVWXYZ

# Function to perform the Caesar cipher encryption/decryption
caesar_cipher() {
  local input="$1"
  local output="$2"
  local shift="$3"
  local text=`cat $input`
  # Check if the input file exists
  if [[ ! -f "$input" ]]; then
    echo "Error: Input file '$input' not found."
    exit 1
  fi

  # Perform the Caesar cipher transformation and write to the output file
  sed "y/$a/${a:$shift}${a::$shift}/; y/$b/${b:$shift}${b::shift}/" "$input" > "$output"
}

# Parse command-line arguments
while getopts "s:i:o:" opt; do
  case "$opt" in
    s)
      shift_value="$OPTARG"
      ;;
    i)
      input_file="$OPTARG"
      ;;
    o)
      output_file="$OPTARG"
      ;;
    \?)
      echo "Invalid option: -$OPTARG"
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument."
      exit 1
      ;;
  esac
done

# Check if all required options are provided
if [[ -z "$shift_value" || -z "$input_file" || -z "$output_file" ]]; then
  echo "Usage: $0 -s <shift> -i <input file> -o <output file>"
  exit 1
fi

# Call the function with the provided arguments
caesar_cipher "$input_file" "$output_file" "$shift_value"

