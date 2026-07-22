#!/bin/bash

# Provide the desired machine name as the first positional argument and the corresponding image that was built as the second positional argument

create_machine() {

	local name="$1"
	local image="$2"

	if [ -z "$name" ] || [ -z "$image" ]; then
		echo "Usage: $0 <machine_name> <image>"
		exit 1
	fi

	container machine create --set-default --cpus 2 --memory 4G --home-mount=none --name "$name" "$image"
	container machine run
}

create_machine "$1" "$2"
