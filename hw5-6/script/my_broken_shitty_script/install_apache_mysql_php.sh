#!usr/bin/bash

# install and configure apache
sudo -y apt update
sudo -y apt install apache2
sudo ufw allow in "Apache Full"

# install mysql server
sudo -y apt install mysql-server
sudo -y mysql_secure_installation << EOF
n
666
666
y
y
y
y
EOF

# sudo systemctl reload apache2
sudo apt -y install php libapache2-mod-php php-mysql
