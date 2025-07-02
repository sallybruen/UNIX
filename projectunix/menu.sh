 #!/bin/bash
logfile="logs/$(date +'%Y-%m-%d')stocks.log"
datestring="%n%d-%m-%Y %H:%M:%S"
selection=""
menuOptionOne() {
     echo "Collect and Move Files"
     cd files
     ./collectfiles.sh
     cd ..
}

menuOptionTwo() {
		echo "Consolidate & Filter the Data"
		echo "Enter Start Year"
		read start_year
		echo "Enter End Year"
		read end_year
		date -d"+1 hour" -u +"$datestring Checking start year and end year values." >>$logfile
		if [[ ! "$start_year" =~ ^[0-9]+$ ]] || [[ ! "$end_year" =~ ^[0-9]+$ ]]; then
			printf "Error: Both start year and end year must be valid numbers. Try again.\n\n"
	 		date -d"+1 hour" -u +"$datestring Error: Start year or end year are not valid numbers. Files not consolidated." >>$logfile
			menuOptionTwo
		elif [ "$start_year" -gt "$end_year" ]; then
			printf "Error: Start year cannot be greater than end year. Try again.\n\n"
	 		date -d"+1 hour" -u +"$datestring Error: Start year is greater than end year. Files are consolidated." >>$logfile
			menuOptionTwo
		elif [ "$start_year" -gt  2015 ] ||[ "$end_year" -gt  2015 ]; then
			printf "Error: Start year or end year cannot be greater than 2015. Try again.\n\n"
			date -d"+1 hour" -u +"$datestring Error: Start year or end year are greater than 2015. Files are consolidated." >>$logfile
			menuOptionTwo
		else
			cd files
			./consolidate.sh $start_year $end_year
			cd ..
		fi
}

menuOptionThree() {
     echo "Opening & Closing Values"
     cd files
     ./stats.sh 
     cd ..
}

menuOptionFour() {
     echo "Earliest & Latest Stock Dates"
     cd files
     ./earliestlatest.sh
     cd ..
}

menuOptionFive() {
		echo "Logging Output for $(date +'%Y-%m-%d')"
		cat $logfile
}

incorrectSelection() {
     echo "Incorrect Option. Try again"
}

pressEnter() {
     echo ""
     echo "  Press Enter to continue"
     read
     clear
}
until ["$selection" = "0"]; do
	clear
	echo "		Menu"
	echo "	1 - Collect and Move Files"
	echo "	2 - Consolidated & Filter the Data"
	echo "	3 - Highest & Lowest Opening & Closing Values"
	echo "	4 - Earliest & Latest Stock Dates"
	echo "	5 - Show Logging Output"
	echo "	0 - Exit"
	echo ""
	echo -n " Enter Menu Option "
	read selection
	echo ""
	case $selection in
	    1) clear; menuOptionOne; pressEnter;;
	    2) clear; menuOptionTwo; pressEnter;;
	    3) clear; menuOptionThree; pressEnter;;
	    4) clear; menuOptionFour; pressEnter;;
		 5) clear; menuOptionFive; pressEnter;;
	    0) clear; exit;;
	    *) clear; incorrectSelection; pressEnter;;
	esac
done
