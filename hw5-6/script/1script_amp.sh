#!usr/bin/bash
sudo apt-get -y install apache2 mysql-server 
sudo ufw allow in "Apache Full"
sudo mysql_secure_installation<<EOF
n
666
666
y
y
y
y
EOF
sudo apt-get -y install php libapache2-mod-php php-mysql
