#!/bin/bash

sudo apt update

#instalacao do agente zabbix
sudo wget https://repo.zabbix.com/zabbix/4.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_4.0-2+bionic_all.deb 
sudo dpkg -i zabbix-release_4.0-2+bionic_all.deb 


#execute apt install para fazer a instalacao do zabbix-agent
sudo apt install zabbix-agent -y


sudo systemctl stop zabbix-agent

#Edite o arquivo zabbix_agentd.conf no /etc/zabbix e altere as linhas
sudo sed -i "s/Server=127.0.0.1/Server=10.0.80.68/"  /etc/zabbix/zabbix_agentd.conf
sudo sed -i "s/ServerActive=127.0.0.1/ServerActive=10.0.80.68/" /etc/zabbix/zabbix_agentd.conf
sudo sed -i "s/Hostname=Zabbix server/Hostname=Ustorage 40/" /etc/zabbix/zabbix_agentd.conf

sudo systemctl enable zabbix-agent
sudo systemctl start zabbix-agent
sudo systemctl status zabbix-agent 

