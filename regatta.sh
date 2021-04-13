#!/bin/bash

# A competitive rowing game between Oxford and Cambridge
# To run in a terminal under any version of GNU Linux
# Developed by Elizabeth Mills
# 12th July 2020

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

# Commentary arrays
Good[0]="are looking good"
Good[1]="are digging deep"
Good[2]="have upped their stroke rate"
Good[3]="have found their rhythm"
Good[4]="are going for it"
Good[5]="have the bend in their favour"

Bad[0]="are looking untidy"
Bad[1]="are struggling to find their rhythm"
Bad[2]="have shipped an oar"
Bad[3]="have clashed"
Bad[4]="look dreadfully outclassed"
Bad[5]="have the bend against them"

Chat[0]="The champagne has arrived ... cheers!"
Chat[1]="The sun has come out, and is shining down like a big, firey ball in the sky"
Chat[2]="There's a chilly wind blowing across the course"
Chat[3]="Clouds are building up, it looks as though the rain may come back"
Chat[4]="It's started to rain again"
Chat[5]="The rain seems to be easing"

function Main {  # All steps are called from here
	clear
	echo
	echo -e "\e[31m\e[1mWELCOME TO REGATTA"
	echo
	echo -e "Here's a review of the two teams ... "
	echo
	
	Preparation		# Initialises variables

	Race			# The race
}

function Preparation {
	# Declare and display variables for average height, weight, strength, stamina and skill for each boat
	OxfordHeight=$((175+($RANDOM % 3 )))		# eg: 176cm
	OxfordWeight=$((70+($RANDOM % 3 )))			# eg: 72kg
	OxfordStrength=$((100+($RANDOM % 3 )))	# eg: 101% body weight lift
	OxfordStamina=$((96+($RANDOM % 3 )))		# eg: 98%
	OxfordSkill=$((96+($RANDOM % 3 )))			# eg: 97%
	OxfordBoat=$((99+($RANDOM % 3 )))				# eg: 99%
	OxfordTotal=$((OxfordHeight+OxfordStrength+OxfordStamina+OxfordSkill+OxfordBoat-OxfordWeight))
	echo -e "\e[34m\e[1mOxford: H=$OxfordHeight W=$OxfordWeight Str=$OxfordStrength Sta=$OxfordStamina Sk=$OxfordSkill Total=$OxfordTotal\e[0m"
	CambridgeHeight=$((175+($RANDOM % 3 )))		# eg: 175cm
	CambridgeWeight=$((70+($RANDOM % 3 )))		# eg: 78kg
	CambridgeStrength=$((100+($RANDOM % 3 )))	# eg: 110% body weight lift
	CambridgeStamina=$((96+($RANDOM % 3 )))		# eg: 60%
	CambridgeSkill=$((96+($RANDOM % 3 )))			# eg: 90%
	CambridgeBoat=$((99+($RANDOM % 3 )))			# eg: 101%
	CambridgeTotal=$((CambridgeHeight+CambridgeStrength+CambridgeStamina+CambridgeSkill+CambridgeBoat-CambridgeWeight))
	echo -e "\e[36m\e[1mCambridge: H=$CambridgeHeight W=$CambridgeWeight Str=$CambridgeStrength Sta=$CambridgeStamina Sk=$CambridgeSkill Total=$CambridgeTotal\e[0m"
	
	WaterDragFactor=$((150-($RANDOM % 300 )))		# Current: 100% is neutral >100% is head, <100% is tail
	echo -e "\e[31m\e[1m"
	if [ $WaterDragFactor -gt 0 ]; then
		echo "They are rowing against the tide today"
	elif [ $WaterDragFactor -lt 0 ]; then
		echo "The tide is with them today"
	else
		echo "The tide is full today"
	fi
	echo
	
	RaceLength=$((250+($RANDOM % 1000 )))			# Random race length between 50 and 200 meters
	echo -e "Today's race is $RaceLength meters."
	
	read -p "Press enter to start the race"			# Allow for betting
	
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
	
	# Convert each boat's stroke to a distance
	OxfordSweep=$((OxfordStroke*OxfordStrokeRate))
	CambridgeSweep=$((CambridgeStroke*CambridgeStrokeRate))
}

function Race {  						# From start to finish
	echo
	echo -e "They're off!"
	echo

	# Define loop variables and start loop
	Lead=0
	Counter=0
	Done=0
	Weather=$((($RANDOM % 6 )))
	while [ $Done -eq 0 ]
    do
    	RandomEvent=$((($RANDOM % 6 )))
		BadEvent="${Bad[${RandomEvent}]}"
		GoodEvent="${Good[${RandomEvent}]}"

		Weather=$((Weather + 1))
		if [ $Weather -gt 5 ]; then Weather=$RandomEvent; fi
		RandomCommentary="${Chat[${Weather}]}"

		CambridgeBoat=$((98+($RANDOM % 3 )))		# eg: 90%
		# Update Lead with new Sweep calcs and add a random factor
		Event=$((2-($RANDOM % 5)))
		if [ $Event -gt 1 ]; then
			echo -e "\e[36m\e[1mMistake by Cambridge!\e[0m"
		elif [ $Event -lt -1 ]; then
			echo -e "\e[34m\e[1mMistake by Oxford!\e[0m"
		elif [ $Event -lt 0 ]; then
			if [ $Counter -gt $((RaceLength / 2)) ]; then
				echo -e "\e[34m\e[1mOxford $BadEvent\e[0m"
			else
				echo -e "\e[36m\e[1mCambridge $GoodEvent\e[0m"
			fi
		elif [ $Event -gt 0 ]; then
			if [ $Counter -gt $((RaceLength / 2)) ]; then
				echo -e "\e[36m\e[1mCambridge $BadEvent\e[0m"
			else
				echo -e "\e[34m\e[1mOxford $GoodEvent\e[0m"
			fi
		else
			echo -e "\e[0m$RandomCommentary\e[0m"
		fi
		echo
		Event=$((Event / 2))
		
    	RandomEvent=$((($RANDOM % 6 )))
		BadEvent="${Bad[${RandomEvent}]}"
		GoodEvent="${Good[${RandomEvent}]}"
		
		Lead=$(( Lead + ( OxfordSweep / 10 ) - ( CambridgeSweep / 10 ) + Event))
		Counter=$((Counter+25))
		if [ $Lead -lt -10 ]; then
			echo -e "\e[36m\e[1mCambridge $BadEvent\e[0m"
			Lead=$((Lead / 2))
		elif [ $Lead -gt 10 ]; then
			echo -e "\e[34m\e[1mOxford $BadEvent\e[0m"
			Lead=$((Lead / 2))
		fi
		
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
				echo "The race finished a dead heat!"
				break
			elif [ $Lead -gt 0 ]; then				# Oxford win
				Winner="Oxford"
			else									# Cambridge wins
				Winner="Cambridge"
				Lead=$((-1 * Lead))
			fi
			
			echo
			echo "$Winner won by $Lead $Meters"

			Done=1
		elif [ $Lead -gt 0 ]; then
			echo -e "\e[34m\e[1mAt the $Counter meter marker, Oxford lead by $Lead $Meters"
		elif [ $Lead -lt 0 ]; then
			echo -e "\e[36m\e[1mAt the $Counter meter marker, Cambridge lead by $((-1*Lead)) $Meters"
		else
			echo "At the $Counter meter marker, they are neck and neck"
		fi
		echo
		
        # Apply fatigue
        OxfordStrokeRate=$((OxfordStrokeRate-OxfordDrag+OxfordStamina))
    	CambridgeStrokeRate=$((CambridgeStrokeRate-CambridgeDrag+CambridgeStamina))
    	
		# Recalculate each sweep distance
		OxfordSweep=$((OxfordStroke*OxfordStrokeRate*OxfordBoat/100000))
		CambridgeSweep=$((CambridgeStroke*CambridgeStrokeRate*CambridgeBoat/100000))
		
		if [ $Counter -ge $RaceLength ]; then
			Done=1
		fi
		
		sleep 3
		
    done
		
	echo -e "\e[0m"							# Reset text colour
    
}

Main
echo -e "\e[0m"							# Reset text colour
read -p "Press enter to quit"				# Allow for self-closing terminal
