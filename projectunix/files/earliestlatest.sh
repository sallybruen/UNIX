#!/bin/bash
if [ ! -f "filtered_stocks.csv" ]; then
    echo "Error: Filtered stocks file not found. Please run option 1 & 2 first."
    exit 1
fi

printf "\nEarliest Date by Stock\n"
awk 'BEGIN{FS=OFS="\t"} NR > 1 {if (a[$1] == "" || $2 < a[$1]) {a[$1]=$2; data[$1]=$1" was "$2" for "$3}} END{for (i in a) print data[i]}' filtered_stocks.csv
read filteris

printf "\nLatest Date by Stock\n"
awk 'BEGIN{FS=OFS="\t"} NR > 1 {if (a[$1] == "" || $2 > a[$1]) {a[$1]=$2; data[$1]=$1" was "$2" for "$3}} END{for (i in a) print data[i]}' filtered_stocks.csv

