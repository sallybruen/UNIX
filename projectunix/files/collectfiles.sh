#!/bin/bash
logfile="../logs/$(date +'%Y-%m-%d')stocks.log"
datestring="%n%d-%m-%Y %H:%M:%S"
date -d"+1 hour" -u +"$datestring Reading stock files from clone directory."  >>$logfile
expected_header="Date,Open,High,Low,Close,Volume,Adj Close"

found_files=false
for file in ../../downloads/stocks/*_daily.csv; do
	if [ -e "$file" ]; then
		found_files=true
      break
   fi
done

if ! $found_files; then
    date -d"+1 hour" -u +"$datestring Error: No stock files found in the current directory." >>$logfile
    echo "No stock files found. Exiting."
    exit 1
fi

for filename in $(ls ../../downloads/stocks);
	do
		if [[ "$filename" = *".csv" ]]; then
			first_line=$(head -n 1 ../../downloads/stocks/"$filename" | tr -d '\r' | tr -d '\n')
			if [[ "$first_line" == "$expected_header" ]]; then
				mv ../../downloads/stocks/"$filename" /home/fdmuser/project/files
				echo "Moved: $filename";
				date -d"+1 hour" -u +"$datestring $filename moved." >>$logfile
			else
				echo "Not Moved: $filename (Invalid header)"
				date -d"+1 hour" -u +"$datestring $filename not moved (invalid header)." >>$logfile
			fi
		else
			echo "Not Moved: $filename (Not a CSV file)"
			date -d"+1 hour" -u +"$datestring $filename not moved (not a CSV file)." >>$logfile
		fi
done
date -d"+1 hour" -u +"$datestring Valid stock files moved to new directory." >>$logfile
