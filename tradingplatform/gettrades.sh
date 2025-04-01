awk 'BEGIN {FS=OFS=","} NR==FNR {k[$1] = $2" "$3;next} {print $1,$2,k[$3],$4,$5,$6}' brokers.csv trades.csv > values.csv
awk 'BEGIN {FS=OFS=","} NR==FNR {k[$1] = $2;next} {print $1,k[$2],$3}' companies.csv shares.csv > companiesare.csv
awk 'BEGIN {FS=OFS=","} NR==FNR {k[$1] = $3"("$2")";next} {print $1,$2,k[$3]}' currencies.csv companiesare.csv > sharesare.csv
awk 'BEGIN {FS=OFS=","} NR==FNR {k[$1] = $2","$3;next} {print $1,k[$2],$3,$4,$5,$6}'  sharesare.csv values.csv > alltrades.csv
awk 'BEGIN {FS=OFS=","} NR==FNR {k[$1] = $2"("$3")";next} {print $1,$2,$3,$4,k[$5],$6,$7}' stock_exchanges.csv alltrades.csv > newtrades.csv
echo "display trades group by companies"
awk 'BEGIN {FS=OFS=","} {if(NR!=1) a[$0]=$1","$2","$3","$4","$5","$6","$7} END{for (i in a) print a[i]}' newtrades.csv | sort -t\, -k2,2
echo "Number of trades by companies"
awk 'BEGIN {FS=OFS=","} {if(NR!=1) {a[$0]=$2}} END{for (i in a) print a[i]}' newtrades.csv | sort -t\, -k1,1 | uniq -c
echo "Number of trades by brokers"
awk 'BEGIN {FS=OFS=","} {if(NR!=1) {a[$0]=$4}} END{for (i in a) print a[i]}' newtrades.csv | sort -t\, -k1,1 | uniq -c
echo "Number of trades by companies and brokers"
awk 'BEGIN {FS=OFS=","} {if(NR!=1) {a[$0]=$2" "$4}} END{for (i in a) print a[i]}' newtrades.csv | sort -t\, -k1,1 | uniq -c
awk 'NR>1 {print $0}' newtrades.csv > alltrades.txt
echo "enter price"
read priceis
echo "trades which are equal to or over $priceis"
awk -F"," -v valueis="$priceis" '$7>=valueis {a[$0]=$2","$7 n++} END{for (i in a) print i} END{printf("There are %d trades which are %d or over\n",n, valueis)}' alltrades.txt
