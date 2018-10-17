#!/bin/bash

#install some default tooling
sudo yum update -y
curl --silent --location https://rpm.nodesource.com/setup_8.x | sudo bash -  
sudo yum install curl wget nodejs make git nginx -y
sudo yum groupinstall -y 'Development Tools'
sudo npm install -g yarn

# Install Wetty (Web Console)

sudo yarn global add wetty

sudo cat << EOC > /etc/init/wetty.conf
# Upstart script

description "Web TTY"
author      "Wetty"

start on runlevel [2345]
stop on shutdown

respawn
respawn limit 20 5

exec sudo -u root /usr/local/bin/wetty -p 3000 --sshuser ${ssh_user}
EOC

sudo start wetty  

# Create new user, edit ssh settings
sudo adduser ${ssh_user} 
echo '${ssh_pass}' | sudo passwd ${ssh_user} --stdin
sudo sed -ie 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config

sudo service sshd reload

# Set up NGINX 

cat <<EOF > /etc/nginx/nginx.conf
user nginx;
worker_processes auto;
error_log /var/log/nginx/error.log;
pid /var/run/nginx.pid;

include /usr/share/nginx/modules/*.conf;

events {
    worker_connections 1024;
}

http {
    server {
        listen       80 default_server;
        listen       [::]:80 default_server;
        server_name  localhost;
        root         /usr/share/nginx/html;

        location / {
            proxy_pass   http://127.0.0.1:3000;
        }
    }
}
EOF

sudo service nginx start
sudo chkconfig nginx on

####################################################################
##### Add your Use-Case specific configuration below this line #####
##----------------------------------------------------------------##