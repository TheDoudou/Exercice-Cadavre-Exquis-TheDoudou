																	# $1 is stage 2.1
if [ $1 ]; then														# Check first argument
	if [ $2 ]; then													# And second if true
		if [[ `wget -S --spider $1  2>&1 | grep 'HTTP/1.1 200 OK'` ]]; then	# Check if first argument is ok
			cd ~/ && mkdir tmp/ && cd tmp/							# Work in tempory directory
			git clone $1 											# Stage 2.2
			cd $(ls)												# Go to only one directory
			git branch -a && git pull && git checkout developpement # Stage 2.3 2.4 2.5
			git branch $2 && git checkout $2						# Stage 2.6
			cat $(ls)												# Print story
			echo "" && echo "Tapez votre ajout de texte : (tapez EOF à la fin pour valider le texte)" && echo ""
			read -d "EOF" ajout_perso								# Read user input with end of line support Stage 2.7 Start	
			#if [[ `sed -n '$p' $(ls)` != ""]]; then
				echo -e "\r"
			#fi
			echo "$ajout_perso" >> $(ls)							# Ajout de l'entrée au readme Stage 2.7 End
			git add $(ls) && git commit -m "Add story from $2"		# Stage 2.8 2.9
			git push												# Stage 2.10
			git checkout developpement && git merge $2				# Stage 2.11
			git push												# Stage 2.12
			cd ../../ && sudo rm -r tmp/							# Clean all
		else
			echo "Wrong url"										# If wrong url
		fi
	else
		echo "Need branch name : ./auto-cadavre.sh <repo git url> <name branch> [commit comment]" # If second argument is false
	fi
else
	echo "Sorry argument required : ./auto-cadavre.sh <repo git url> <name branch> [commit comment]" # If first argument blablabla
fi

