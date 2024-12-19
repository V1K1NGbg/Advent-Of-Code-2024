#!/bin/bash

# ./7.1.sh

is_possible() {
	local arr=("$@")
	local n=${#arr[@]}
	if [ $n -eq 1 ]; then
		if [ "${arr[0]}" -eq "$goal" ]; then
			return 0
		else
			return 1
		fi
	fi


	local mul=($((arr[0] * arr[1])) "${arr[@]:2}")

	if is_possible "${mul[@]}"; then
		return 0
	fi


	local add=($((arr[0] + arr[1])) "${arr[@]:2}")

	if is_possible "${add[@]}"; then
		return 0
	fi

	return 1
}

sum=0

while read line; do

	goal=$(awk '{print $1}' <<< $line | tr -d ":")

	IFS=" " read -r -a arr <<< $(awk '{$1=""; print $0}' <<< $line)

	if is_possible "${arr[@]}"; then
		sum=$((sum + $goal))
	fi
done < input/7.txt

echo $sum