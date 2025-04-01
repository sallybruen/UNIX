#!/bin/bash
sourcefile=diamonds.csv
outputfile=diamondsData.csv
logfile=../logs/diamond.log
max=18500
min=18000
datestring="%n%d-%m-%Y %H:%M:%S"
#exec > >(tee -a ../logs/$logfile) 2>&1
date -d"+1 hour" -u +"$datestring reading from $sourcefile started" >>$logfile
awk 'BEGIN{FS=","} {if(NR!=1) {a[$0]=$2","$3","$4","$8}} END{for (i in a) print a[i]}' $sourcefile > $outputfile
sort -t\, -k2,2 -k4,4rn $outputfile > diamondsSorted.csv
printf '\nLowest Diamond Prices By Cut\n'
date -d"+1 hour" -u +"$datestring processing data" >>$logfile
printf "\nHighest price by cut\n"
awk 'BEGIN{FS=OFS=","} {if (a[$2]<$4) {a[$2]=$4; data[$2]=$2" is "$4}} END{for (i in a) print data[i]}' diamondsSorted.csv


printf "\nLowest price by cut\n"
awk 'BEGIN{FS=OFS=","} {if (a[$2]<$4) {a[$2]<$4; data[$2]=$2" is "$4}} END{for (i in a) print data[i]}' diamondsSorted.csv
echo -n "enter cut: "
read cut
printf "\ncut that is $cut and price > $min\n"
read
awk -F"," -v patternis="$cut" -v minis="$min" '$0~patternis{if($4 > minis)  print $1" "$2" "$4}' $outputfile
read
printf "all cuts between $min and $max\n"
awk -F"," -v patternis="$cut" -v minis="$min" -v maxis="$max"  '$0~patternis{if($4 > minis && $4 < maxis)  print $1" "$2" "$4}' $outputfile
read
val=1000
aval=$((min-val))
printf "\n\nfor cut=$cut and price between $aval and $max sort the price in ascending order\n"
read
awk -F","  -v patternis="$cut" -v minis="$aval" -v maxis="$max" '$2==patternis && $4 > minis && $4 < maxis  { {icount++}  {a[$0]=$1"\t"$2"\t\t"$4}} END{ for (i in a) print a[i]} END{printf (icount) " occurances"}'  $outputfile | sort -r -k3,3
read
printf "\n\nall rows with $cut between $min and $max\n"
awk -F","  -v patternis="$cut" -v minis="$min" -v maxis="$max" '$2==patternis && $4 > minis && $4 < maxis  { {icount++}  print $1"\t"$2"\t\t"$4}  END{print (icount) " occurances"}'  $outputfile | sort -r -k4,4   
printf "$counter"
date -d"+1 hour" -u +"$datestring diamonds completed" >>$logfile

