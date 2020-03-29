
echo 'Sudo for pip3 install (and python3)'
sudo apt-get update
sudo apt-get --quiet install python3-pip
sudo apt-get --quiet install python3
echo ''>> ~/.bashrc
echo '#fuck python2' >> ~/.bashrc
echo 'alias python='\''python3'\' >> ~/.bashrc
echo 'alias pip='\''pip3'\' >> ~/.bashrc
source ~/.bashrc
