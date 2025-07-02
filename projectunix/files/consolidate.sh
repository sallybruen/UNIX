#!/bin/bash
logfile="../logs/$(date +'%Y-%m-%d')stocks.log"
datestring="%n%d-%m-%Y %H:%M:%S"

start_year=$1
end_year=$2

date -d"+1 hour" -u +"$datestring Start year and end year are valid. Processing stocks files to be consolidated." >>$logfile

output_file="filtered_stocks.csv"
temp_file="temp_sorted.csv"
first_file=true
rm -f "$output_file"

found_files=false
for file in *_daily.csv; do
    if [ -e "$file" ]; then
        found_files=true
        break
    fi
done

if ! $found_files; then
    date -d"+1 hour" -u +"$datestring Error: No stock files found in the current directory." >>$logfile
    printf "\nNo stock files found. Exiting.\n"
    exit 1
fi
for file in *_daily.csv; do
    stock_name=$(echo "$file" | cut -d'_' -f 1)
    echo "Processing: $stock_name"
	 date -d"+1 hour" -u +"$datestring $stock_name file processed." >>$logfile
    
    if $first_file; then
        awk -v stock="$stock_name" -v start_year="$start_year" -v end_year="$end_year" 'BEGIN {FS=","; OFS="\t"} 
			NR==1 {print "Stock\t\tDate\t\tOpen\t\tClose\t\tPriceDiff\tPercentDiff"; next}

            {
                year = substr($1, 1, 4);
                if (year >= start_year && year <= end_year && $5 >= $2) {
                    pricediff = $5 - $2;
                    percentdiff = ($2 == 0) ? 100 : (pricediff / $2) * 100;
                    printf "%-12s\t%-12s\t%-10s\t%-10s\t%-12s\t%-12s\n", stock, $1, $2, $5, pricediff, percentdiff;
					}
            }' "$file" >> "$output_file"
        first_file=false
    else
        awk -v stock="$stock_name" -v start_year="$start_year" -v end_year="$end_year" 'BEGIN {FS=","; OFS="\t"} 
            NR>1 {
                year = substr($1, 1, 4);
                if (year >= start_year && year <= end_year && $5 >= $2) {
                    pricediff = $5 - $2;
                    percentdiff = ($2 == 0) ? 100 : (pricediff / $2) * 100;                    
						  printf "%-12s\t%-12s\t%-10s\t%-10s\t%-12s\t%-12s\n", stock, $1, $2, $5, pricediff, percentdiff;
                }
            }' "$file" >> "$output_file"
    fi
done

header=$(head -n 1 "$output_file")
tail -n +2 "$output_file" | sort -t$'\t' -k1,1 -k2,2 > "$temp_file"
echo "$header" > "$output_file"
cat "$temp_file" >> "$output_file"
rm -f "$temp_file"

echo
echo "All matching data has been consolidated, filtered (by start year and end year), and sorted (by stock and date) into $output_file"
date -d"+1 hour" -u +"$datestring File consolidation completed." >>$logfile
