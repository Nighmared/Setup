#Script to install the Brave Browser [nightly Relase version]
sudo apt -qq install apt-transport-https curl

curl -s https://brave-browser-apt-nightly.s3.brave.com/brave-core-nightly.asc | sudo apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-prerelease.gpg add -

echo "deb [arch=amd64] https://brave-browser-apt-nightly.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-nightly.list

sudo apt -qq update

sudo apt -qq install brave-browser-nightly

echo 'Brave Installed'
