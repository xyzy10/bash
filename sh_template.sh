#!/usr/local/bin/bash

# This script creates a template for notes.

# Step 1:
# use -z to Check if we argument 1 is empty or not, since we use it as the file name
if [ -z $1 ]
then
	echo "Please supply file name, and short description."
	exit 0
fi

# create a file
filename=$1.sh
touch $filename
chmod +x $filename

# -e flag allow echo to evaluate escaped characters.
echo -e "#!/usr/local/bin/bash\n" > $1.sh


# Step 2:
# Stop creating the description if argument 2 is empty
if [ -z "$2" ]
then
	exit 0
fi


# This fucntion adds a box to contain the description
# eg printDes "hello world"
printDes() {
	local des=$1
	let local des_length=${#des}+2
	local seperator='-'

	# seq -s * 8  | tr -d '[:digit:]' will repeatly print * sign 8 times 
	# seq -s * 8 outputs 1 to 8 and add seperator * between each output, resulting 1*2*3*4* etc
	# then we use the translate tr command to remove all the digits from preview output resulting just ********
	# then we pipe it to cat to add prefix and subfix to the output
	# cat <(printf "prefix") <cat() <(printf "subfix")
	seq -s $seperator $des_length | tr -d '[:digit:]' | cat <(printf "\n#") <(cat) <(printf "\n") >> $filename
	printf "# $des\n" >> $filename
	seq -s $seperator $des_length | tr -d '[:digit:]' | cat <(printf "#") <(cat) <(printf "\n") >> $filename
}


printDes "$2"





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


cat $filename
