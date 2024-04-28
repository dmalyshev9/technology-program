#!/bin/bash

if [ ! -d "$1" ] || [ ! -d "$2" ]; then
	echo «Оба параметра должны быть существующими директориями.»
	exit 1
fi

mycp () {
	local source="$1"
	local target="$2"

	local n=""
	local filename=$(basename -- "$source")
	local name="${filename%.*}"
	local extension="${filename##*.}"

	target="$target/$filename"

	while [ -e "$target$n" ]; do
		n=$(( n + 1 ))
	done

	if [ -n "$n" ]; then
		target="$target$n"
		if [ "$extension" != "$filename" ]; then
			target="$name$n.$extension"
		fi
	fi
	
	cp "$source" "$target"
}


while IFS= read -r -d '' file; do
	mycp "$file" "$2"
done < <(find "$1" -type f -print0)

exit 0