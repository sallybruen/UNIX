clear
awk 'BEGIN{FS=","} {if(NR!=1) {a[$0]=$1","$2","$3","$4","$5","$6","$7","$8","$9}  } END{for (i in a) print a[i]}' premier.csv > table.csv

displayTitle()
{
	printf "Team(s) that have %s %s %s\n" $2 $1 $3
}

endCategory()
{
	read 
	printf "\n\n\n"
}

displayTitle least played games
values=$(awk 'BEGIN{FS=OFS=","} val=="" || $2 < val {val=$2} END {print val}' table.csv)
awk -F"," -v valueis=$values '{if($2==valueis) print $1" "$2}' table.csv | sort -t\, -k1,1n
endCategory

displayTitle most played games
values=$(awk 'BEGIN{FS=OFS=","} val=="" || $2 > val {val=$2} END {print val}' table.csv)
awk -F"," -v valueis=$values '{if($2==valueis) print $1" "$2}' table.csv | sort -t\, -k1,1n
endCategory


displayTitle least scored goals
values=$(awk 'BEGIN{FS=OFS=","} val=="" || $6 < val {val=$6} END {print val}' table.csv)
awk -F"," -v valueis=$values '{if($6==valueis) print $1" "$6}' table.csv | sort -t\, -k1,1n
endCategory


displayTitle most scored goals
values=$(awk 'BEGIN{FS=OFS=","} val=="" || $6 > val {val=$6} END {print val}' table.csv)
awk -F"," -v valueis=$values '{if($6==valueis) print $1" "$6}' table.csv | sort -t\, -k1,1n
endCategory



displayTitle percentage best
values=$(awk 'BEGIN{FS=OFS=","} val=="" || $9 > val {val=$9} END {print val}' table.csv)
awk -F"," -v valueis=$values '{if($9==valueis) printf "%s %3.2f ", $1, 100*$9/($2*3)}' table.csv | sort -t\, -k1,1n
endCategory

displayTitle percentage worst
values=$(awk 'BEGIN{FS=OFS=","} val=="" || $9 < val {val=$9} END {print val}' table.csv)
awk -F"," -v valueis=$values '{if($9==valueis) printf "%s %3.2f ", $1, 100*$9/($2*3)}' table.csv | sort -t\, -k1,1n
endCategory


awk -F"," '{goals=goals+$6} {games=games+$2} END {printf "Average Goals Scored by Team %2.2f", goals/games}' table.csv
endCategory


