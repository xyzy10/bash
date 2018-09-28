#!/usr/bin/env bash

# This script takes repo name as argument and creates a new repo under /srv/git directory
# the repo name must only contain numeric, alphabetic and dash sign(not start with) value

if [ -z "$1" ]; then
	echo "Please supply repo name as first argument"
	exit 1
fi

REPO_NAME="$1"

# Only allow numeric, alphabetic and dash sign value as new repo name.
# Also make sure the dash sign is not at the front.
if [[ "$REPO_NAME" =~ ^[a-zA-Z0-9\-]+$ && ! "$REPO_NAME" =~ ^- ]]; then
	DIR_NAME="/srv/git/${REPO_NAME}.git"	
	
	# Need to make sure we don't re initlize the existing repo.
	# Checking the directory exit and not a symbolic link.
	if [[ -d "$DIR_NAME" && ! -L "$DIR_NAME" ]]; then
		echo "Error: Repo ${DIR_NAME} already exited."
		exit 4
	fi

	mkdir "$DIR_NAME"
	cd "$DIR_NAME"

	# only init the repo if no error
	if [ $? -eq 0 ]; then
		git init --bare
	else
		echo "Something wrong. Repo not initialized."
		exit 3
	fi
else
	echo "Repo name can only contains numeric and alphabetic value."
	exit 2
fi
