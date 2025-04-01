awk 'BEGIN{FS=","} {if(NR!=1)  {a[$0]=$2","$3","$4","$8}} END{for (i in a) print a[i]}' diamonds.csv > colorsorted.csv
sort -t\, -k3,3 -k4,4rn colorsorted.csv > diamondColors.csv
printf "\nHighest price by color\n"
awk 'BEGIN{FS=OFS=","} {if (a[$3]<$4) {a[$3]=$4; data[$3]=$3" is "$4}} END{for (i in a) print data[i]}' diamondColors.csv
printf "\nLowest price by color\n"
awk 'BEGIN{FS=OFS=","} {if (a[$3]<$4) {a[$3]<$4; data[$3]=$3" is "$4}} END{for (i in a) print data[i]}' diamondColors.csv
testvalue=$1
awk -F"," -v valueis="$testvalue" '$4<=valueis {x[$0]=$1","$2","$3","$4} END{for (i in x) print i}' colorsorted.csv > colorsorted2.csv
sort -t\, -k3,3 -k4,4rn colorsorted2.csv > diamondColors2.csv
printf "\n\nHighest price by color up to $testvalue\n"
awk 'BEGIN{FS=OFS=","} {if (a[$3]<$4) {a[$3]=$4; data[$3]=$3" is "$4}} END{for (i in a) print data[i]}' diamondColors2.csv
