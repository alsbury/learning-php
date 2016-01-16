#!/usr/bin/env bash

printf "\n"
printf "Provisioning as "
whoami

add-apt-repository ppa:ondrej/php5-5.6

apt-get update
apt-get install python-software-properties

printf "Installing Apache..."
apt-get -y install apache2
printf "Patching Apache config file to handle known sendfile() issue with VirtualBox..."
echo "#" >> /etc/apache2/apache2.conf
echo "# Patch for known sendfile() issue with VirtualBox" >> /etc/apache2/apache2.conf
echo "EnableSendfile off" >> /etc/apache2/apache2.conf
printf "done\n"

printf "Installing MySQL..."
echo "mysql-server-5.5 mysql-server/root_password password sandbox" | debconf-set-selections
echo "mysql-server-5.5 mysql-server/root_password_again password sandbox" | debconf-set-selections
apt-get -y install mysql-server-5.5 mysql-client-core-5.5

printf "Installing PHP..."
apt-get -y install php5 php5-cli php5-mysql php5-redis php5-xdebug php5-mcrypt php5-xhprof php5-xcache php5-intl php5-gd php5-sqlite php5-json php5-curl
apt-get -y install npm node
apt-get -y install libapache2-mod-php5

a2dismod mpm_event
a2enmod rewrite
a2enmod mpm_prefork
a2enmod ssl

./sync_site_configs.sh

a2dissite 000-default.conf
a2ensite 00_www.conf

service apache2 restart

npm install -g gulp bower

printf "Installing Composer..."
curl -sS https://getcomposer.org/installer | php > /dev/null 2>&1
mv composer.phar /usr/local/bin/composer
printf "done\n"

printf "Installing Java...\n"
apt-get -y install default-jre
# apt-get install default-jdk

printf "Installing WebDriver...\n"
curl -o /var/www/project/bin/selenium-server-standalone-2.46.0.jar http://selenium-release.storage.googleapis.com/2.46/selenium-server-standalone-2.46.0.jar

printf "Setting default working directory for vagrant user to /var/www/project in .bashrc...\n"
echo "cd /var/www/project" >> /home/vagrant/.bashrc

printf "Vagrant provisioning complete! Enjoy!\n"
