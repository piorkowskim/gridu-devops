#!/bin/bash

# Function to print usage information
print_usage() {
  echo "Usage: $0 -o <operation> -n <numbers> [-d]"
}

# Initialize variables
operation=""
numbers=()
debug=1

# Function to print debug information
print_debug_info() {
  echo "User: $(whoami)"
  echo "Script: $0"
  echo "Operation: $operation"
  echo "Numbers: ${numbers[*]}"
}

# Process command-line arguments
while [[ $# -gt 0 ]]; do
  case "$1" in
    -o)
      shift
      operation="$1"
      ;;
    -n)
      shift
      while [[ $# -gt 0 && ! "$1" =~ ^- ]]; do
        numbers+=("$1")
        shift
      done
      ;;
    -d)
      debug=0
      shift
      ;;
     +|%|-|\*)
      operation="$1"
      shift
      ;;
    *)
      echo "Invalid option: $1"
      print_usage
      exit 1
      ;;
  esac
done

# Validate input
if [[ -z "$operation" || ${#numbers[@]} -lt 2 ]]; then
  print_usage
  exit 1
fi

# Perform the calculation based on the provided operation
result=0
case "$operation" in
  +)
    for num in "${numbers[@]}"; do
      ((result += num))
    done
    ;;
  -)
    result="${numbers[0]}"
    for ((i = 1; i < ${#numbers[@]}; i++)); do
      ((result -= numbers[i]))
    done
    ;;
  %)
    result="${numbers[0]}"
    for ((i= 1; i < ${#numbers[@]}; i++)); do
       ((result %= numbers[i]))
    done
    ;;
  \*)
     result="${numbers[0]}"
     for ((i = 1; i < ${#numbers[@]}; i++)); do
        ((result *= numbers[i]))
     done
     ;;
  *)
    echo "Invalid operation: $operation"
    print_usage
    exit 1
    ;;
esac

# Output the result
echo "Result: $result"
# Print debug information if -d flag is passed
if [[ $debug -eq 0 ]]; then
     print_debug_info
fi
