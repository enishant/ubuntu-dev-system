# Upgrade system
sudo apt-get update
sudo apt-get upgrade -y

# Remove default apps & games
sudo apt-get remove -y gnome-mahjongg gnome-mines gnome-sudoku
sudo apt-get remove -y rhythmbox
sudo apt-get autoremove -y

# Install GIT
sudo apt-get install -y git git-gui

# Install ssh server
sudo apt-get install -y openssh-server
sudo systemctl enable ssh
sudo ufw allow ssh
sudo systemctl start ssh

# Install htop, net-tools, nmap, whois
sudo apt-get install -y htop
sudo apt-get install -y net-tools
sudo apt-get install -y nmap
sudo apt-get install -y whois

# Install Python venv
sudo apt-get install -y python3.10-venv

# Docker Installation
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done

# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

# Install latest Docker version
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-compose

# Add Docker service
sudo systemctl enable docker.service
sudo systemctl enable containerd.service

# Create the docker group, Add your user to the docker group, 
sudo groupadd docker
sudo usermod -aG docker $USER
su - $USER

# Create dev directory
mkdir ~/dev
mkdir ~/dev/lamp

# Install NES Emulator
sudo apt-get install -y nestopia
cd ~/dev
git clone https://github.com/enishant/Nesroms.git Nesroms
chmod 755 ~/dev/Nesroms/UbuntuApps/*.desktop
cp ~/dev/Nesroms/UbuntuApps/*.desktop ~/.local/share/applications

# Install VLC Media Player
sudo apt-get install -y vlc

# Create LAMP server
cd ~/dev/lamp
git clone https://github.com/enishant/docker-compose-lamp.git p82
cd p82
git fetch --all
git checkout feat-virtual-hosts
cp sample.env .env
docker-compose up -d

# Install Node.js 20.x | Reference: https://deb.nodesource.com/
sudo apt-get update && sudo apt-get install -y ca-certificates curl gnupg
curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
NODE_MAJOR=20
echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list
sudo apt-get update && sudo apt-get install nodejs -y
