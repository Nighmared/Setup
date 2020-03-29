printf 'About to do a full installation, continue? (y/n) '
read start
echo "$*"
if [ $start = "y" ] || [ $start = "yes" ]; then
	#============================
	#sources all at once so apt only is updated once :))
	#Brave sources
	printf "Adding Brave sources \r"
	sudo apt-get --quiet install apt-transport-https curl >> /dev/null 2>&1
	curl -s https://brave-browser-apt-nightly.s3.brave.com/brave-core-nightly.asc | sudo apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-prerelease.gpg add - >> /dev/null 2>&1
	echo "deb [arch=amd64] https://brave-browser-apt-nightly.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-nightly.list >>/dev/null 2>&1
	echo "Brave sources added            "
	#Typora sources
	printf "Adding Typora sources \r"
	wget --quiet -qO - https://typora.io/linux/public-key.asc | sudo apt-key add - >> /dev/null 2>&1
	sudo add-apt-repository 'deb https://typora.io/linux ./' >> /dev/null 2>&1
	echo "Typora sources added            "


	echo "All sources Added"
	#============================
	printf $"Updating sources\r"
	sudo apt-get --quiet update >> /dev/null 2>&1
	echo "Sources Updated                      "

	#Installations
	toInstall=$(tr '\n' ' ' <allInstalls.txt)

	if [[ "$*" == *"--nopython"* ]]; then
		toInstall=$(sed -e 's/python3-pip//' -e 's/python3//' <<< "$toInstall")
	fi
	if [[ "$*" == *"--nobrave"* ]]; then
		toInstall=$(sed -e 's/brave-browser-nightly//' <<< "$toInstall")
	fi
	if [[ "$*" == *"--nospotify"* ]]; then
		toInstall=$(sed -e 's/spotify-client//' <<< "$toInstall")
	fi
	if [[ "$*" == *"--notypora"* ]]; then
		toInstall=$(sed -e 's/typora//' <<< "$toInstall")
	fi
	if [[ "$*" == *"--nocode"* ]]; then
		toInstall=$(sed -e 's/code//' <<< "$toInstall")
	fi

	toInstall=$(sed -e 's/  / /' <<< "$toInstall") #eliminate tons of spaces
	
	#echo $toInstall

	printf "Installing everything...\r"
	sudo apt-get --quiet install $toInstall >> /dev/null 2>&1
	echo "Installation Done                   "
	

	#Python
	if [[ "$*" != *"nopython"* ]]; then
		echo ''>> ~/.bashrc
		echo '#fuck python2' >> ~/.bashrc
		echo 'alias python='\''python3'\' >> ~/.bashrc
		echo 'alias pip='\''pip3'\' >> ~/.bashrc
		echo 'Python Optimizations done'
	fi
	

	echo 'Setup done'
else
	echo 'Aborted'
fi
