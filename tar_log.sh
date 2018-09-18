#!/usr/bin/env bash



# remove the trailing slash then apeend /* to the directory
if ! [ -d $1 ]; then
	echo "First argument must be a directory"
	exit 1
fi


PROCESS_DIR="${1%/}/*"

COMPRESS_DIR="./compressed_logs"

for file in ${PROCESS_DIR}
do
	if [[ "$file" = *".tgz"* ]];then
		continue
	fi
	
	DIR=${file%/*}
	LOG_DIR=${COMPRESS_DIR}/$DIR

	if ! [ -d "${LOG_DIR}" ]; then
		mkdir -p "${LOG_DIR}"
		echo "Directory ${LOG_DIR} created." 
	fi
	
	FILENAME="${file##*/}"
	tar -czvf ${LOG_DIR}/${FILENAME}.tgz $file
done
