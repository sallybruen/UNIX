#!/bin/bash
selection=""
menuOptionOne() {
     echo "Diamond Data"
     cd diamonds
     ./getdiamonds.sh
     cd ..
}

menuOptionTwo() {
     echo "Get Diamond Data By Color"
     echo "Enter Price"
     read price
     cd diamonds
     ./colorDiamonds.sh $price
     cd ..
}

menuOptionThree() {
     echo "Trades Data"
     cd tradingplatform 
     ./gettrades.sh 
     cd ..
}

menuOptionFour() {
     echo "Bank Data"
     cd bankdata
     ./bank.sh
     cd ..
}

menuOptionFive() {
     echo "Football Stats"
     cd football
     ./maxmin.sh
}

incorrectSelection() {
     echo "Incorrect Option. Try again"
}

pressEnter() {
     echo ""
     echo "  Press Enter to continue"
     read
     clear
}

until ["$selection" = "0"]; do
	clear
	echo "		Menu"
	echo "	1 - Diamond Dataset Commands"
	echo "	2 - Diamond Dataset By Color"
	echo "	3 - Trades Dataset"
	echo "	4 - Bank Dataset"
	echo "	5 - Football Stats"
	echo "	0 - Exit"
	echo ""
	echo -n " Enter Menu Option "
	read selection
	echo ""
	case $selection in
	    1) clear; menuOptionOne; pressEnter;;
	    2) clear; menuOptionTwo; pressEnter;;
	    3) clear; menuOptionThree; pressEnter;;
	    4) clear; menuOptionFour; pressEnter;;
	    5) clear; menuOptionFive; pressEnter;;
	    0) clear; exit;;
	    *) clear; incorrectSelection; pressEnter;;
	esac
done
