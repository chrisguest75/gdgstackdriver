#Upgrade OS
#Install Docker

#https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/
sudo apt-get update
sudo apt-get install     apt-transport-https     ca-certificates     curl     software-properties-common
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository    "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install docker-ce
sudo usermod -aG docker $(whoami)
exit

#relogin and try the sanity test
sudo docker run hello-world


#stackdriver
sudo curl -sSO https://repo.stackdriver.com/stack-install.sh
sudo bash stack-install.sh --write-gcm
sudo curl -sSO https://dl.google.com/cloudagents/install-logging-agent.sh
sudo bash install-logging-agent.sh


# use gcp logs driver
sudo systemctl stop docker
sudo echo '{"log-driver":"gcplogs"}' | sudo tee /etc/docker/daemon.json
sudo systemctl start docker
