#!/bin/bash

echo "##################################################"
echo "# Configuring ZF Sandbox"
echo "##################################################"

# Test if Apache is installed
apache2 -v > /dev/null 2>&1
APACHE_IS_INSTALLED=$?

# Test if PHP is installed
php -v > /dev/null 2>&1
PHP_IS_INSTALLED=$?

# Test if unzip is installed
unzip -v > /dev/null 2>&1
UNZIP_IS_INSTALLED=$?

# Test if git is installed
git --version > /dev/null 2>&1
GIT_IS_INSTALLED=$?

# Install dependency

if [[ $APACHE_IS_INSTALLED -ne 0 ]]; then
	echo "Install apache2"
	apt-get install apache2 -y > /dev/null
  mkdir -p /var/www/html
else
  echo "apache2 checked"
fi

if [[ $PHP_IS_INSTALLED -ne 0 ]]; then
	echo "Install php"
  apt-get install php5 php5-curl php5-mcrypt php5-mysql -y > /dev/null
  php5enmod curl
  php5enmod mcrypt
  php5enmod mysql
else
  echo "php5 checked"
fi

if [[ $UNZIP_IS_INSTALLED -ne 0 ]]; then
	echo "Install unzip"
  apt-get install unzip -y > /dev/null
else
  echo "unzip checked"
fi

if [[ $GIT_IS_INSTALLED -ne 0 ]]; then
	echo "Install git"
  apt-get install git -y > /dev/null
else
  echo "git checked"
fi


# config apache2

if [ ! -f /etc/apache2/mods-enabled/rewrite.load ]; then
  a2enmod rewrite
fi

if [ ! -f /etc/apache2/mods-enabled/ssl.load ]; then
  a2enmod ssl
fi

if [ ! -f /etc/apache2/conf-enabled/synaptop.com.conf ]; then
  cp /home/vagrant/c/apache/conf-available/synaptop.com.conf /etc/apache2/conf-available/
  a2enconf synaptop.com
fi

cp /home/vagrant/c/apache/sites-available/www.synaptop.dev.conf /etc/apache2/sites-available/
a2ensite www.synaptop.dev