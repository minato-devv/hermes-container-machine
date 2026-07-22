#!/bin/bash

create_machine() {

	local base="$1"
	local image="$2"
	local name="$3"

	if [ -z "$name" ] || [ -z "$image" ] || [ -z "$base" ]; then
		echo "Usage: $0 <base image: debian or ubuntu> <target image> <machine_name>"
		exit 1
	fi

	container build -t "$image" --file "$base/Containerfile" .
	container machine create --set-default --no-boot --cpus 2 --memory 4G --home-mount=none --name "$name" "$image"
	container machine run
}

create_machine "$1" "$2" "$3"
