#!/bin/bash

mysqlPassword=$1
adminServer=$2
sudo apt-get update

#another way of installing mysql server in a Non-Interactive mode
echo "mysql-server-5.6 mysql-server/root_password password '$mysqlPassword'" | sudo debconf-set-selections 
echo "mysql-server-5.6 mysql-server/root_password_again password '$mysqlPassword'" | sudo debconf-set-selections 

#install mysql-server 5.6
sudo apt-get -y install mysql-server-5.6

sed -i "s/bind-address[[:space:]]*\=[[:space:]]*[0-9]\{1,3\}.[0-9]\{1,3\}.[0-9]\{1,3\}.[0-9]\{1,3\}/bind-address=0.0.0.0/g" /etc/mysql/my.cnf

mysql -uroot -p$mysqlPassword -e "CREATE USER '$adminServer'@'%' IDENTIFIED BY '$mysqlPassword';"
mysql -uroot -p$mysqlPassword -e "GRANT ALL PRIVILEGES ON *.* TO '$adminServer'@'%';"
mysql -uroot -p$mysqlPassword -e "FLUSH PRIVILEGES;"
service mysql restart
