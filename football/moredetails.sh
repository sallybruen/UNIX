awk 'BEGIN{FS=","}{if (NR!=1) {a[$0]=$2","$6","$7}} END { for (i in a) print a[i] }' premier.csv > tablesorted.csv
sort -t\, -k1,1 -k2,2rn tablesorted.csv > newtable.csv
printf "\nMost goals scored by games played\n"
awk 'BEGIN{FS=OFS=","} {if (a[$1]<$2) {a[$1]=$2; data[$1]=$2" goals in "$1" games " }}END {for (i in a) print data[i]} ' newtable.csv


printf "\nLeast goals scored by games played\n"
awk 'BEGIN{FS=OFS=","} {if (a[$1]<$2) {a[$1]<$2; data[$1]=$2" goals in "$1" games " }}END {for (i in a) print data[i]} ' newtable.csv


sort -t\, -k1,1 -k3,3rn tablesorted.csv > newtable.csv
printf "\nMost goals conceded by games played\n"
awk 'BEGIN{FS=OFS=","} {if (a[$1]<$3) {a[$1]=$3; data[$1]=$3" goals in "$1" games " }}END {for (i in a) print data[i]} ' newtable.csv

printf "\nLeast goals conceded by games played\n"
awk 'BEGIN{FS=OFS=","} {if (a[$1]<$3) {a[$1]<$3; data[$1]=$3" goals in "$1" games " }}END {for (i in a) print data[i]} ' newtable.csv
