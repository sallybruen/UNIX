#!/bin/bash
if [ ! -f "filtered_stocks.csv" ]; then
    echo "Error: Filtered stocks file not found. Please run options 1 & 2 first."
    exit 1
fi

printf "\nHighest Prices\n"
printf "\nHighest Opening Price by Stock\n"
awk 'BEGIN{FS=OFS="\t"} NR > 1 {if (a[$1]<$3) {a[$1]=$3; data[$1]=$1" was "$3" on "$2}} END{for (i in a) print data[i]}' filtered_stocks.csv
read filteris

printf "\nHighest Closing Price by Stock\n"
awk 'BEGIN {FS=OFS="\t"} NR > 1 {if (a[$1]<$4) {a[$1]=$4; data[$1]=$1" was "$4" on "$2}} END{for (i in a) print data[i]}' filtered_stocks.csv
read filteris

printf "\n\nLowest Prices\n"
printf "\nLowest Opening Price by Stock\n"
awk 'BEGIN{FS=OFS="\t"} NR > 1 {if (a[$1]<$3) {a[$1]<$3; data[$1]=$1" was "$3" on "$2}} END{for (i in a) print data[i]}' filtered_stocks.csv
read filteris
printf "\nLowest Closing Price by Stock\n"
awk 'BEGIN{FS=OFS="\t"} NR > 1 {if (a[$1]<$4) {a[$1]<$4; data[$1]=$1" was "$4" on "$2}} END{for (i in a) print data[i]}' filtered_stocks.csv
