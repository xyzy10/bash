#!/usr/bin/env bash

# Do not do anything if no directory to work on.
if [ -z "$1" ]; then
	echo "Missing directory as argument 1"
	exit 1	
fi

# Remove the trailing slash then apeend /* to the directory.
if ! [ -d "$1" ]; then
	echo "First argument must be a directory"
	exit 1
fi

# Remove the training / from the arugment and concat /* to the end.
# eg argument log/ will turn into log/*
PROCESS_DIR="${1%/}/*"

# The directory to store the compressed files
COMPRESS_DIR="./compressed"

# The list of extension that we do not want to gzip.
EXCLUDE_EXT=(".tgz" ".zip" ".bz2" ".gz" ".lz" ".lzma" ".lzo" ".rz" ".sfark" ".sz" ".cpio" ".shar" ".LBR" ".iso" ".lbr" ".mar" ".sbx" ".tar" ".7z" ".s7z" ".ace" ".afa" ".alz" ".apk" ".arc" ".rar" ".bz2")


for file in ${PROCESS_DIR}
do
	# If the file extension match to the skip list then we do not want to gzip it.
	SKIP=0
	for ext in ${EXCLUDE_EXT[@]}
	do
		# Check the laset 3/4 character of file for extension.
		if [[ ${file: -3} == "$ext" || ${file: -4} == "$ext" || ${file: -5} == "$ext" || ${file: -6} == "$ext" ]]; then
			SKIP=1
			break
		fi
	done

	if [ "$SKIP" -eq 1 ]; then
		continue
	fi
	
	# Get the directory name form the arugment 1
	DIR=${file%/*}
	# Create the save directory insidet the compress directory
	STORE_DIR=${COMPRESS_DIR}/$DIR

	# Make directory if not exist 
	if ! [ -d "${STORE_DIR}" ]; then
		mkdir -p "${STORE_DIR}"
		echo "Directory ${STORE_DIR} created." 
	fi
	
	# Extract the filename and gzip it
	FILENAME="${file##*/}"
	tar -czvf ${STORE_DIR}/${FILENAME}.tgz $file
done
