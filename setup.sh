printf 'About to do a full installation, continue? (y/n) '
read start
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
	printf "Installing everything...\r"
	sudo apt-get --quiet install $toInstall >> /dev/null 2>&1
	echo "Installation Done                   "
	


	#Python
	if [ $1 != "nopython" ] && [ $1 != "-nopython" ]; then
		echo ''>> ~/.bashrc
		echo '#fuck python2' >> ~/.bashrc
		echo 'alias python='\''python3'\' >> ~/.bashrc
		echo 'alias pip='\''pip3'\' >> ~/.bashrc
		echo 'Python Optimizations done'
	else
		echo "nopython parameter found; Nothing added to .bashrc"
	fi
	

	echo 'Setup done'
else
	echo 'Aborted'
fi
