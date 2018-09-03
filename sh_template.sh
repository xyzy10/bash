#!/usr/bin/env bash

# This script creates a template for notes.

# Step 1:
# use -z to Check if we argument 1 is empty or not, since we use it as the file name
if [ -z $1 ]
then
	echo "Please supply file name, and short description."
	exit 0
fi

# create a file
FILE_NAME=$1.sh
touch $FILE_NAME
chmod +x $FILE_NAME

# -e flag allow echo to evaluate escaped characters.
echo -e "#!/usr/bin/env bash\n" > $FILE_NAME 


# Step 2:
# Stop creating the description if argument 2 is empty
if [ -z "$2" ]
then
	exit 0
fi


# This fucntion adds a box to contain the description
# eg printDes "hello world"
printDes() {
	local DES=$1
	let local DES_LENGTH=${#DES}+3
	local SEPERATOR='-'

	# seq -s * 8  | tr -d '[:digit:]' will repeatly print * sign 8 times 
	# seq -s * 8 outputs 1 to 8 and add seperator * between each output, resulting 1*2*3*4* etc
	# then we use the translate tr command to remove all the digits from preview output resulting just ********
	# then we pipe it to cat to add prefix and subfix to the output
	# cat <(printf "prefix") <cat() <(printf "subfix")
	seq -s $SEPERATOR $DES_LENGTH | tr -d '[:digit:]' | cat <(printf "\n#") <(cat) <(printf "") >> $FILE_NAME
	printf "# $DES\n" >> $FILE_NAME
	seq -s $SEPERATOR $DES_LENGTH | tr -d '[:digit:]' | cat <(printf "#") <(cat) <(printf "\n\n\n") >> $FILE_NAME
}


printDes "$2"

vim $FILE_NAME



# Another way to add multi line contents to a file is to use the << method
#cat >$filename <<EOL
# ------------------------
# $2
# ------------------------
#EOL


# Or we can use while loop to create all the seperators to contain argument 2
# the drawback is we have do it twice 
#i=0

#while [ $i -lt $des_length ]
#do
#	printf "-" >> $filename
#	let i=i+1
#done




#printf '*%.0s' {1..${des_length}"}


