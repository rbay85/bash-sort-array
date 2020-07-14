#!/usr/bin/env bash

# comparator is used to sort array ascending/descending
comparator='-gt'
order='Ascending'

# alter comparator if -r or --reverse is the 1st param
case "$1" in
	-r|--reverse)
		comparator='-lt'
		order='Descending'
		shift
		;;
esac

# get array from params
array=( "$@" )

#check if numbers
check(){
	for element in "${array[@]}"; do
		if ! [[ $element =~ ^[0-9]+$ ]] ; then
			echo 'error: NaN'
			exit 1
		fi
	done
	echo "Initial array is: ${array[@]}"

}

# sorting (https://en.wikipedia.org/wiki/insertion_sort)
sort(){
	i=1
	n=${#array[@]}
	while ((i < n)); do
		k=${array[i]} 
		j=$(( i-1 ))
		while [ "${j}" -ge 0 ] && [ "${array[j]}" "${comparator}" "${k}" ]; do
			array[j+1]=${array[j]} 
			((j--))
		done 
		array[j+1]=$k;
		((i++))
	done
	echo "${order} sorted array is: ${array[@]}"
}

check

sort
