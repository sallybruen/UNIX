awk 'BEGIN {FS=OFS=","} NR==FNR {k[$1] = $2" "$3;next} {print $1,$2,k[$3],$4,$5,$6}' brokers.csv trades.csv > values.csv
awk 'BEGIN {FS=OFS=","} NR==FNR {k[$1] = $2;next} {print $1,k[$2],$3}' companies.csv shares.csv > companiesare.csv
awk 'BEGIN {FS=OFS=","} NR==FNR {k[$1] = $3"("$2")";next} {print $1,$2,k[$3]}' currencies.csv companiesare.csv > sharesare.csv
awk 'BEGIN {FS=OFS=","} NR==FNR {k[$1] = $2","$3;next} {print $1,k[$2],$3,$4,$5,$6}'  sharesare.csv values.csv > alltrades.csv
awk 'BEGIN {FS=OFS=","} NR==FNR {k[$1] = $2"("$3")";next} {print $1,$2,$3,$4,k[$5],$6,$7}' stock_exchanges.csv alltrades.csv > newtrades.csv
