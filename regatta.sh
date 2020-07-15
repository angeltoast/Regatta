#!/bin/bash

# A competitive rowing game between Oxford and Cambridge
# To run in a terminal under any version of GNU Linux
# Developed by Elizabeth Mills
# Start date: 12th July 2020

# Don't forget to make executable (chmod +x regatta.sh)

# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful, but
#      WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
#            General Public License for more details.

# A copy of the GNU General Public License is available from the Feliz2
#        page at http://sourceforge.net/projects/feliz2/files
#        or https://github.com/angeltoast/feliz2, or write to:
#                 The Free Software Foundation, Inc.
#                  51 Franklin Street, Fifth Floor
#                    Boston, MA 02110-1301 USA

function Main {  # All steps are called from here
	clear
	echo
	# Declare and display variables
	# Average height, weight, strength, stamina and skill for each boat
	OxfordHeight=$((175+($RANDOM % 5 )))		# eg: 175cm
	OxfordWeight=$((70+($RANDOM % 5 )))			# eg: 78kg
	OxfordStrength=$((98+($RANDOM % 5 )))		# eg: 110% body weight lift
	OxfordStamina=$((95+($RANDOM % 5 )))		# eg: 80%
	OxfordSkill=$((95+($RANDOM % 5 )))			# eg: 90%
	OxfordBoat=$((98+($RANDOM % 2 )))			  # eg: 90%
	OxfordTotal=$((OxfordHeight+OxfordStrength+OxfordStamina+OxfordSkill+OxfordBoat-OxfordWeight))
	echo -e "\e[34m\e[1mOxford: H=$OxfordHeight W=$OxfordWeight Str=$OxfordStrength Sta=$OxfordStamina Sk=$OxfordSkill Total=$OxfordTotal\e[0m"
	CambridgeHeight=$((175+($RANDOM % 5 )))		# eg: 175cm
	CambridgeWeight=$((70+($RANDOM % 5 )))		# eg: 78kg
	CambridgeStrength=$((98+($RANDOM % 5 )))	# eg: 110% body weight lift
	CambridgeStamina=$((95+($RANDOM % 5 )))		# eg: 60%
	CambridgeSkill=$((95+($RANDOM % 5 )))		  # eg: 90%
	CambridgeBoat=$((98+($RANDOM % 2 )))		  # eg: 90%
	CambridgeTotal=$((CambridgeHeight+CambridgeStrength+CambridgeStamina+CambridgeSkill+CambridgeBoat-CambridgeWeight))
	echo -e "\e[36m\e[1mCambridge: H=$CambridgeHeight W=$CambridgeWeight Str=$CambridgeStrength Sta=$CambridgeStamina Sk=$CambridgeSkill Total=$CambridgeTotal\e[0m"

	WaterDragFactor=$((150-($RANDOM % 300 )))	# Current: 100% is neutral >100% is head, <100% is tail
	
	RaceLength=$((250+($RANDOM % 1000 )))			# Random race length between 50 and 200 meters
	
	# Pre-race calculations
	# 1) Convert crew Height to Stroke length (3:4)
	OxfordStroke=$((OxfordHeight/2))
	CambridgeStroke=$((CambridgeHeight/2))
	# 2) Combine crew Strength and Skill to get DrivingForce
	OxfordForce=$((OxfordStrength*OxfordSkill/10))
	CambridgeForce=$((CambridgeStrength*CambridgeSkill/10))
	# 3) Combine WaterDragFactor and crew Weight to get TotalDragFactor
	OxfordDrag=$((WaterDragFactor+OxfordWeight))
	CambridgeDrag=$((WaterDragFactor+CambridgeWeight))
	# 4) Calculate crew StrokeRate from (Stroke x Skill/100)
	OxfordStrokeRate=$((OxfordHeight/OxfordStrength))
	CambridgeStrokeRate=$((CambridgeHeight/CambridgeStrength))
    
  Race	# Start the race
}

function betamount {  # Input bet
	while [ $Done -eq 0 ]
	do
		echo	# Drop a line
		echo -e "\e[1mPlease enter your bet amount"
		read -p "Or just press [Enter] to start the race £" Amount
		Done=1
		echo
	done	
}

function Race {  # From start to finish
	echo -e "\e[31m\e[1m"
	echo "Today's race is $RaceLength meters."
	echo
	if [ $WaterDragFactor -gt 0 ]; then
		echo "They are rowing against the tide today"
	elif [ $WaterDragFactor -lt 0 ]; then
		echo "The tide is with them today"
	else
		echo "The tide is full today"
	fi
	echo
	if [ $CambridgeTotal -gt $OxfordTotal ]; then
		echo "Cambridge are the favourites, with odds of 3 to 2"
		Winnings=3
	elif [ $CambridgeTotal -lt $OxfordTotal ]; then
		echo "Oxford are the favourites, with odds of 3 to 2"
		Winnings=3
	else
		echo "The odds are 2 to 1 on Oxford or Cambridge"
		Winnings=4
	fi
	Done=0
	while [ $Done -eq 0 ]
	  do
	    echo	# Drop a line
			echo -e "If you would like to bet on the race, please first type either Oxford or Cambridge"
			read -p "Or just press [Enter] to start the race: " Bet
			bet="${Bet,,}"
	    case $bet in
			"") Exit=1
			;;
			"oxford") Bet="Oxford"
			betamount
			;;
			"cambridge") Bet="Cambridge"
			betamount
			;;
			*) echo "Sorry, your entry '$Bet' is incompattible, please enter again"
	    esac
	  done
	clear
	echo
	echo -e "They're off!\e[0m"
	echo
	# Convert each boat's stroke to a distance
	OxfordSweep=$((OxfordStroke*OxfordStrokeRate))
	CambridgeSweep=$((CambridgeStroke*CambridgeStrokeRate))
	# Define loop variables and start loop
	Lead=0
	Counter=0
	while true
    do
		Counter=$((Counter+10))
		# Update Lead with new Sweep calcs and add a random factor
		Event=$((1-($RANDOM % 3)))
		if [ $Event -lt -1 ]; then
			echo -e "\e[36m\e[1mOh no, that's a mistake by Cambridge!\e[0m"
		elif [ $Event -gt 1 ]; then
			echo -e "\e[34m\e[1mOh no, that's a mistake by Oxford!\e[0m"
		elif [ $Event -lt 0 ]; then
			echo -e "\e[36m\e[1mCambridge are pulling hard!\e[0m"
		elif [ $Event -gt 0 ]; then
			echo -e "\e[34m\e[1mOxford are pulling hard!\e[0m"
		fi
		Lead=$(( Lead + ( OxfordSweep / 10 ) - ( CambridgeSweep / 10 ) + Event))
		# If meters are singular or plural
		if [ $Lead -eq 1 ] || [ $Lead -eq -1 ]; then
			Meters="metre"
		else
			Meters="metres"
		fi
		# Display commentary
		if [ $Counter -ge $RaceLength ]; then		# Race end
			if [ $Lead -eq 0 ]; then				# No winner
				echo
				echo -e "\e[1mThe race finished a dead heat!\e[0m"
			elif [ $Lead -gt 0 ]; then				# Oxford win
				Winner="Oxford"
			else									# Cambridge wins
				Winner="Cambridge"
				Lead=$((-1 * Lead))
			fi
			
			if [ "$Bet" = "$Winner" ]; then
				echo
				echo -e "\e[34m\e[1mCongratulations, $Winner win by $Lead $Meters : You win £$((Amount * Winnings / 2))\e[0m"
			else
				echo
				echo -e "\e[34m\e[1mCommisserations, $Winner win by $Lead $Meters\e[0m"
			fi
			echo -e "\e[0m"
			break
		elif [ $Lead -gt 0 ]; then
			echo -e "\e[34m\e[1mAt the $Counter meter marker, Oxford lead by $Lead $Meters\e[0m"
		elif [ $Lead -lt 0 ]; then
			echo -e "\e[36m\e[1mAt the $Counter meter marker, Cambridge lead by $((-1*Lead)) $Meters\e[0m"
		else
			echo -e "\e[1mAt the $Counter meter marker, they are neck and neck\e[0m"
		fi
      
        # Apply fatigue
        OxfordStrokeRate=$((OxfordStrokeRate-OxfordDrag+OxfordStamina))
    	CambridgeStrokeRate=$((CambridgeStrokeRate-CambridgeDrag+CambridgeStamina))
		# Recalculate each sweep distance
		OxfordSweep=$((OxfordStroke*OxfordStrokeRate*OxfordBoat/100000))
		CambridgeSweep=$((CambridgeStroke*CambridgeStrokeRate*CambridgeBoat/100000))
		
		if [ $Counter -ge $RaceLength ]; then
			exit
		fi
		
		sleep 2
		
    done
}

Main
read -p "Press enter to clear"
clear
