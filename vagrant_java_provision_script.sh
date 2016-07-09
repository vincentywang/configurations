#!/bin/bash

echo "##################################################"
echo "########### Configuring Java Sandbox #############" 
echo "##################################################"
echo "##################################################"
echo "########### Magic begin here... ##################"
echo "##################################################"


# Test if Apache is installed
apache2 -v > /dev/null 2>&1
APACHE_IS_INSTALLED=$?

# Test if mysql is installed
mysql --version > /dev/null 2>&1
MYSQL_IS_INSTALLED=$?

# Test if unzip is installed
unzip -v > /dev/null 2>&1
UNZIP_IS_INSTALLED=$?

# Test if git is installed
git --version > /dev/null 2>&1
GIT_IS_INSTALLED=$?

# Test if svn is installed
svn --version > /dev/null 2>&1
SVN_IS_INSTALLED=$?


# Install MySQL
if [[ $MYSQL_IS_INSTALLED -ne 0 ]]; then
  echo "install mysql"
  debconf-set-selections <<< 'mysql-server mysql-server/root_password password 123'
  debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password 123'
  apt-get -y install mysql-server-5.6 > /dev/null
else
  echo "mysql checked"
fi

# Install NodeJs

# 
# Install utilities
# 

# Install unzip
if [[ $UNZIP_IS_INSTALLED -ne 0 ]]; then
	echo "Install unzip"
  apt-get install unzip -y > /dev/null
else
  echo "unzip checked"
fi

# Install git
if [[ $GIT_IS_INSTALLED -ne 0 ]]; then
	echo "Install git"
  apt-get install git -y > /dev/null
else
  echo "git checked"
fi

# Install svn
if [[ $SVN_IS_INSTALLED -ne 0 ]]; then
  echo "Install svn"
  sudo apt-get install subversion -y > /dev/null
else
  echo "svn checked"
fi


# config tomcat 

# echo "Cloning config folder..."
# if [ -d /home/vagrant/c ]; then
#   rm -Rf /home/vagrant/c
# fi
# cp -R /home/vagrant/config /home/vagrant/c


# echo "copy jdk to usr/local/java"
# if [ -d /home/vagrant/c ]; then
#   rm -Rf /usr/local/java
# fi
# cp -R /home/vagrant/c/java /usr/local/java

# echo "unzip jdk"
# tar -xzvf /usr/local/java/java_7/jdk-7u79-linux-x64.tar.gz


# echo "copy tomcat to usr/local/tomcat"
# if [ -d /home/vagrant/c ]; then
#   rm -Rf /usr/local/tomcat
# fi
# cp -R /home/vagrant/c/tomcat /usr/local/tomcat


# echo "unzip tomcat"
# tar -xzvf /usr/local/tomcat/tomcat_8/apache-tomcat-8.0.15.tar.gz
# 

sudo mkdir /usr/local/jdk

sudo tar -xf /home/vagrant/config/jdk/jdk_7/jdk-7u79-linux-x64.tar -C /usr/local/jdk/

sudo mv /usr/local/jdk/jdk1.7.0_79/ /usr/local/jdk/jdk7/

sudo tar -xf /home/vagrant/config/tomcat/tomcat_7/apache-tomcat-7.0.70.tar -C /opt/

sudo mv /opt/apache-tomcat-7.0.70 /opt/tomcat7
sudo chown -R vagrant:root /opt/tomcat7


sudo echo "JAVA_HOME=/usr/local/jdk/jdk7" >>/home/vagrant/.profile
source /home/vagrant/.profile
sudo echo "JRE_HOME=/usr/local/jdk/jdk7/jre" >> /home/vagrant/.profile
source /home/vagrant/.profile
sudo echo "PATH=$JAVA_HOME/bin:$JRE_HOME:$PATH" >> /home/vagrant/.profile
source /home/vagrant/.profile
sudo echo "CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.ja" >> /home/vagrant/.profile
source /home/vagrant/.profile
sudo echo "TOMCAT_HOME=/opt/tomcat7" >> /home/vagrant/.profile
source /home/vagrant/.profile

sudo echo "alias starttomcat='/opt/tomcat7/bin/startup.sh'" >> /home/vagrant/.profile
sudo echo "alias stoptomcat='/opt/tomcat7/bin/shutdown.sh'" >> /home/vagrant/.profile
source /home/vagrant/.profile

echo "Updating apt-get list..."
# sudo apt-get update > /dev/null


