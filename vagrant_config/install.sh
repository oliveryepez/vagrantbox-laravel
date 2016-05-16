#!/usr/bin/env bash

# Update repositories
echo "|-----------------------------|"
echo "|                             |"
echo "|       Updating system       |"
echo "|                             |"
echo "|-----------------------------|"
apt-get update

#Installing Backends Components
echo "|-----------------------------|"
echo "|                             |"
echo "|       Insatlling Git        |"
echo "|                             |"
echo "|-----------------------------|"
apt-get install -y git

echo "|-----------------------------|"
echo "|                             |"
echo "|       Insatlling NGINX      |"
echo "|                             |"
echo "|-----------------------------|"
apt-get install -y nginx
service nginx stop
sudo rm -f /etc/nginx/sites-available/default.conf
cp /home/vagrant/config/sites.conf.template /etc/nginx/sites-available/default.conf
ln -s /etc/nginx/sites-available/default.conf /etc/nginx/sites-enabled/

service nginx start

echo "|-----------------------------|"
echo "|                             |"
echo "|       Insatlling PHP        |"
echo "|                             |"
echo "|-----------------------------|"
apt-get install python-software-properties build-essential -y
add-apt-repository ppa:ondrej/php5 -y
apt-get update
apt-get install php5-common php5-dev php5-cli php5-fpm -y

echo "|----------------------------------------|"
echo "|                                        |"
echo "|       Insatlling PHP Extensions        |"
echo "|                                        |"
echo "|----------------------------------------|"
apt-get install curl php5-curl php5-gd php5-mcrypt php5-mysql php5-sybase -y


echo "|-------------------------------|"
echo "|                               |"
echo "|       Insatlling MYSQL        |"
echo "|                               |"
echo "|-------------------------------|"
apt-get install debconf-utils -y
debconf-set-selections <<< "mysql-server mysql-server/root_password password root"
debconf-set-selections <<< "mysql-server mysql-server/root_password_again password root"
apt-get install mysql-server -y
mysql -proot --execute="grant all privileges on *.* to 'root'@'%' identified by '1234';"
cp /home/vagrant/config/mysql.cnf /etc/mysql/my.cnf
service mysql restart

echo "|----------------------------------|"
echo "|                                  |"
echo "|       Insatlling Composer        |"
echo "|                                  |"
echo "|----------------------------------|"
php -r "readfile('https://getcomposer.org/installer');" > composer-setup.php
php composer-setup.php --install-dir=/bin --filename=composer
#export PATH="$PATH:/home/vagrant/.config/composer/vendor/bin"
