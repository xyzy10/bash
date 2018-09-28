#--------------------------------------------------------------------
# Create new booking repo from existing template on remote and local
#--------------------------------------------------------------------

createRemoteRepo() {
	# Run the create script on s84 and output the message to stdout.
	ssh s84.ok.ubc.ca /UBC-O/yyong01/scripts/create_new_repo.sh $1
	
	# Get the exit code from remote server.
	return $?
}

REPO_NAME="$1"
BOOKING_TEMPLATE_NAME="bookings-studyroom"

if [ -z "$REPO_NAME" ]; then
	echo "Please supply the project name as first argument."
	exit 1
fi

# Execute the remote script with argument.
MSG=$(createRemoteRepo $REPO_NAME)
EXIT_CODE=$?

# Output any stdout from executing the remote script.
echo $MSG

# We have error from last command.
if ! [ "$EXIT_CODE" -eq 0 ]; then
	echo "Exit code:" "$EXIT_CODE"
	exit 1
fi

# Let's clone the template repo to local first.
git clone s84.ok.ubc.ca:/srv/git/"$BOOKING_TEMPLATE_NAME".git

# If we have not mess anything up at this point, then let's change the remote host
# origin for the newly created repo. So we don't override the origin repo accidentally with our push command.
if [[ "$?" -eq 0 && -d "$BOOKING_TEMPLATE_NAME" ]]; then
	mv $BOOKING_TEMPLATE_NAME $REPO_NAME
	cd $REPO_NAME
	git remote set-url origin yyong01@s84.ok.ubc.ca:/srv/git/"$REPO_NAME".git
	git reset --hard base-code
	git push origin master

	if [[ "$?" -eq 0 ]]; then
		echo "All operation completed."
		exit 0
	else
		echo "Error in last step"
		exit 2 
	fi
fi
