MIKKOKOTILA_TOKEN=$1

sudo apt-get update -y
sudo apt install unzip
sudo journalctl --rotate

# install and configure nginx
sudo apt-get install nginx -y

curl https://raw.githubusercontent.com/mikkokotila/Padma-Infra/_deploy_/Padma-API.conf > Padma-API.conf
curl https://raw.githubusercontent.com/mikkokotila/Padma-Infra/_deploy_/Padma-Frontend.conf > Padma-Frontend.conf

sudo mv Padma-API.conf /etc/nginx/sites-enabled/Padma-API.conf
sudo mv Padma-Frontend.conf /etc/nginx/sites-enabled/Padma-Frontend.conf
sudo nginx -s reload

# install certbot
sudo snap install core; sudo snap refresh core
sudo snap install --classic certbot
sudo ln -s /snap/bin/certbot /usr/bin/certbot

# setup and run docker
sudo apt-get install \
  apt-transport-https \
  ca-certificates \
  curl \
  gnupg-agent \
  software-properties-common -y

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo apt-key fingerprint 0EBFCD88

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

sudo apt-get update -y

sudo snap install core
sudo snap refresh core
sudo snap install --classic certbot
sudo ln -s /snap/bin/certbot /usr/bin/certbot

sudo apt-get install docker-ce docker-ce-cli containerd.io -y
sudo docker login docker.pkg.github.com --username mikkokotila --password $MIKKOKOTILA_TOKEN

# run Padma-API
sudo docker pull ghcr.io/lotus-king-research/padma-backend/core_api:master
NEW_IMAGE_ID=$(sudo docker images | grep core_api | grep master | tail -1 | tr -s ' ' | cut -d ' ' -f3)
sudo docker run --memory=400m --restart unless-stopped --name Padma-API -p 5000:5000 --detach $NEW_IMAGE_ID;

# run Padma-Frontend
sudo docker pull ghcr.io/lotus-king-research/padma-frontend/frontend:master
NEW_IMAGE_ID=$(sudo docker images | grep frontend | grep master | tail -1 | tr -s ' ' | cut -d ' ' -f3)
sudo docker run --memory=100m --restart unless-stopped --name Padma-Frontend -p 8080:8080 --detach $NEW_IMAGE_ID;
