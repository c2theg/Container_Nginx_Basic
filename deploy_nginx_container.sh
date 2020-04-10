#!/bin/sh
#
clear
now=$(date)
echo "Running deploy_nginx_only.sh at $now 
                                  
Created By:
 _____ _       _     _           _              _____    __    _____             
|     | |_ ___|_|___| |_ ___ ___| |_ ___ ___   |     |__|  |  |   __|___ ___ _ _ 
|   --|   |  _| |_ -|  _| . | . |   | -_|  _|  | | | |  |  |  |  |  |  _| .'| | |
|_____|_|_|_| |_|___|_| |___|  _|_|_|___|_|    |_|_|_|_____|  |_____|_| |__,|_  |
                            |_|                                             |___|
\r\n \r\n
Version:  0.0.2                             \r\n
Last Updated:  4/9/2020
\r\n \r\n"
wait
# Starting Point!
# wget https://raw.githubusercontent.com/c2theg/Container_Nginx_Basic/master/deploy_nginx_container.sh && chmod u+x deploy_nginx_container.sh && ./deploy_nginx_container.sh

#---------- Download config files ----------------
wget https://raw.githubusercontent.com/c2theg/Container_Nginx_Basic/master/docker-compose.yml


#-- Create Directories --
mkdir -p /media/data/containers/webserver/conf/
mkdir -p /media/data/containers/webserver/content/
mkdir -p /media/data/containers/webserver/certs/
mkdir -p /media/data/containers/webserver/site_data/


#--- Download content ---
cd /media/data/containers/webserver/conf/
wget https://raw.githubusercontent.com/c2theg/srvBuilds/master/configs/nginx.conf
wget https://raw.githubusercontent.com/c2theg/srvBuilds/master/configs/nginx_global_tls.conf
wget https://raw.githubusercontent.com/c2theg/srvBuilds/master/configs/nginx_global_security.conf
wget https://raw.githubusercontent.com/c2theg/srvBuilds/master/configs/nginx_global_filetypes.conf
wget https://raw.githubusercontent.com/c2theg/srvBuilds/master/configs/nginx_global_logging.conf

wget https://raw.githubusercontent.com/c2theg/Container_Nginx_Basic/master/site_80443_container.conf

#-- Certs ---
cd /media/data/containers/webserver/certs/
wget -O lets-encrypt-x3-cross-signed.pem "https://letsencrypt.org/certs/lets-encrypt-x3-cross-signed.pem"

#-- Extra Content ---
cd /media/data/containers/webserver/content/
wget -O "custom_404.html" "https://raw.githubusercontent.com/c2theg/srvBuilds/master/configs/custom_404.html"
wget -O "custom_50x.html" "https://raw.githubusercontent.com/c2theg/srvBuilds/master/configs/custom_50x.html"


#--- PUT YOU WEBSITE IN HERE!!! ---
cd /media/data/containers/webserver/site_data/
wget -O "index.html" "https://raw.githubusercontent.com/c2theg/srvBuilds/master/configs/index.html"
wget -O "nginx.png" "https://raw.githubusercontent.com/c2theg/srvBuilds/master/configs/nginx.png"
wget -O "f5-logo-tagline-right-solid-rgb-1.png" "https://raw.githubusercontent.com/c2theg/srvBuilds/master/configs/f5-logo-tagline-right-solid-rgb-1.png"


#--- Install Docker ----
wget https://raw.githubusercontent.com/c2theg/srvBuilds/master/install_docker.sh && chmod u+x install_docker.sh && ./install_docker.sh

#--- Download container ---
docker pull nginx:latest
#--- Start Container ---
docker-compose up

docker ps