#!/bin/bash
echo "enter comparison"
read compare
for filename in $(ls ..);
	do
		substring=$(echo $filename | cut -d'.' -f 1)
		echo $substring
		if [[ "$substring" = *"$compare"* ]]; then
			echo "matched";
		else
			echo "not matched"
		fi
done
