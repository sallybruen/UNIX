logfile=../logs/bank.log
datestring="%n%d-%m-%Y %H:%M:%S"
#exec > >(tee -a ../logs/$logfile) 2>&1
date -d"+1 hour" -u +"$datestring reading from bank transaction started"  >>$logfile
date -d"+1 hour" -u +"$datestring processing bank data" >>$logfile
printf "\naccounts that were opened in 2019\n"
awk  -F"," -v patternis="2019" '$5~patternis{{a[$0]=$1"\t"$2"\t\t"$3"\t"$4} {sum++}} END{print "\naccount\t\tcustomer_id  branch_id\ttype"} END{ for (i in a) print a[i]} END{printf "%d accounts opened in %d\n",sum,patternis} ' accounts.csv
read valueis
printf "\naccounts ordered by type\n" 
awk 'NR > 1' transactions.csv | sort -t\, -k3,3rn > transtemp.csv
sed -i -e 's/,/\t/g' transtemp.csv
cat transtemp.csv
read valueis
printf "\nshow business accounts\n" 
awk 'NR > 1' accounts.csv| awk  -F","  '$4==3 {{a[$0]=$1"\t"$2"\t"$3"\t"$4} {count++}}  END{ for (i in a) print a[i]} END{printf"there are %d business accounts\n", count}' 
printf "Enter a year " 
read yearis
echo "accounts opened in $yearis"
awk  -F"," -v patternis="$yearis" '$5~patternis{{a[$0]=$1"\t"$2"\t\t"$3"\t"$4} {sum++}} END{print "\naccount\t\tcustomer_id  branch_id\ttype"} END{ for (i in a) print a[i]} END{printf "%d accounts opened in %d\n",sum,patternis} ' accounts.csv
read valueis
date -d"+1 hour" -u +"$datestring bank transactions completed" >>$logfile


