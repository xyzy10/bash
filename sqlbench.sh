#!/usr/bin/env bash


#----------------------------------------
# MySQL benchmarking with mysqlslap tool
#----------------------------------------

# Test command tool and get user and password.
init() {
	# Make sure we have mysqlslap tool avaliable.
	if ! [ -x "$(command -v mysqlslap)" ]; then
        	echo "Error: mysqlslap does not exist, benchmarking skipped."
        	exit 1
	fi

	# Ask user for mysql root password to run test.
	read -p "Database user name:" USER

	# Ask password with -s flag.	
	read -s -p "Database user password:" PW
	printf "\n"

	# Use -e flag (before -p) and -i flag to create default value. 
	read -e -p "Concurrency:" -i "50" CONCURRENCY
	read -e -p "Iterations:" -i "20" ITERATIONS
}

# Make sure the table exist otherwise quit.
test_table_exist() {
	DBN=$1
	TABLE=$2
	QUERY="SELECT COUNT(*) FROM information_schema.tables WHERE table_schema=\"${DBN}\" AND table_name=\"${TABLE}\";"
	
	run_sql_query "$QUERY"

	if ! [ $QUERY_RESULT -eq 1 ] ; then
		echo "Error: Database table does not eixst"
		exit 2
	fi
}


# Run the sql query, $1 sql query.
run_sql_query() {
	# -N Skip column name in result, -s silent mode.
	QUERY_RESULT=$(mysql -N -s --user="$USER" --password="$PW" -e "$1")
}


# Run the bench marking with mysqlslap tool. 
bench_mark() {
	DBN=$1
	TABLE=$2
	test_table_exist "$DBN" "$TABLE"
	mysqlslap --host=localhost --user="$USER" --password="$PW" --create-schema="$DBN" --query="SELECT * FROM ${TABLE}" --concurrency="$CONCURRENCY" --iterations="$ITERATIONS"
}


main() {
	# Query the database and convert results to array.
        RESULT=('Quit' $(mysql --user="$USER" --password="$PW" -e "show databases;"))

        PS3="Please select a database:"
	
	# Use the array above to generate menu.
        select opt in "${RESULT[@]}"
        do
                case $opt in
                        "Quit")
                        echo "Good byte."
                        exit 0
                        ;;
                esac

		# Query the database again for generating data for table menu.
		RESULT2=('Quit' $(mysql --user="$USER" --password="$PW" -e "USE $opt; SHOW tables;"))

		PS3="Please select a table to benchmark:"

		select opt2 in "${RESULT2[@]}"
		do
			case $opt2 in
				"Quit")
				echo "Good bye"
				exit 0
				;;
			esac

			DBN="$opt"
			TABLE="$opt2"

			bench_mark "$DBN" "$TABLE"
			echo "You selected $opt2"
		done
        done
}


run() {
	init
	main
}


run
