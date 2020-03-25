#!/bin/bash

mysqlPassword=$1
adminServer=$2
sudo apt-get update
#no password prompt while installing mysql server
#export DEBIAN_FRONTEND=noninteractive

#another way of installing mysql server in a Non-Interactive mode
echo "mysql-server-5.6 mysql-server/root_password password $mysqlPassword" | sudo debconf-set-selections 
echo "mysql-server-5.6 mysql-server/root_password_again password $mysqlPassword" | sudo debconf-set-selections 

#install mysql-server 5.6
sudo apt-get -y install mysql-server-5.6

sed -i "s/bind-address[[:space:]]*\=[[:space:]]*[0-9]\{1,3\}.[0-9]\{1,3\}.[0-9]\{1,3\}.[0-9]\{1,3\}/bind-address=0.0.0.0/g" /etc/mysql/my.cnf
#set the password
#sudo mysqladmin -u root password "$mysqlPassword"   #without -p means here the initial password is empty

#alternative update mysql root password method
#sudo mysql -u root -e "set password for 'root'@'localhost' = PASSWORD('$mysqlPassword')"
#without -p here means the initial password is empty

mysql -p$mysqlPassword -e "CREATE USER '$adminServer'@'%' IDENTIFIED BY '$mysqlPassword';"
mysql -p$mysqlPassword -e "GRANT ALL PRIVILEGES ON *.* TO '$adminServer'@'%';"
mysql -p$mysqlPassword -e "FLUSH PRIVILEGES;"


service mysql restart
