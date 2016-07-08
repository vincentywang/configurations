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

sudo mkdir /usr/local/jdk

sudo tar -xf /home/vagrant/config/jdk/jdk_7/jdk-7u79-linux-x64.tar -C /usr/local/jdk/

sudo mv /usr/local/jdk/jdk1.7.0_79/ /usr/local/jdk/jdk7/

sudo tar -xf /home/vagrant/config/tomcat/tomcat_7/apache-tomcat-7.0.70.tar -C /opt/

sudo mv /opt/apache-tomcat-7.0.70 /opt/tomcat7
sudo chown -R vagrant:root /opt/tomcat7
/opt/tomcat7/bin/startup.sh


sudo echo "export JAVA_HOME=/usr/local/jdk/jdk7" >>/home/vagrant/.bashrc
sudo echo "export JRE_HOME=/usr/local/jdk/jdk7/jre" >> /home/vagrant/.bashrc
sudo echo "export PATH=$JAVA_HOME/bin:$PATH" >> /home/vagrant/.bashrc
sudo echo "export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.ja" >> /home/vagrant/.bashrc
sudo echo "export TOMCAT_HOME=/opt/tomcat7" >> /home/vagrant/.bashrc

source ~/.bashrc

echo "Updating apt-get list..."
sudo apt-get update > /dev/null
