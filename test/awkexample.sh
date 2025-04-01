awk 'BEGIN{FS=","} {if(NR!=1) {a[$0]=$1","$2","$3","$4","$5","$6","$7","$8}} END{for (i in a) print a[i]}' ./../football/premier.csv > ./table.csv​
