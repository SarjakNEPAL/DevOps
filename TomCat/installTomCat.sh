sudo apt update
sudo apt install software-properties-common -y
sudo apt install openjdk-8-jdk -y
sudo update-alternatives --config java
echo 'JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64/"' >> /etc/environment
echo '
export JAVA_HOME=/usr/lib/jvm/java-8-oracle/jre
export PATH=$JAVA_HOME/bin:$PATH
' >> ~/.bashrc
source ~/.bashrc
echo $JAVA_HOME
groupadd tomcat
useradd -s /bin/false -g tomcat -d /opt/tomcat tomcat
cd /opt/
wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.98/bin/apache-tomcat-9.0.98.tar.gz
tar -xzvf apache-tomcat-9.0.98.tar.gz
mv apache-tomcat-9.0.98/ tomcat/
mv /opt.tomcat/apache-tomcat-9.0.98/* /opt/tomcat/ 
chown -R tomcat:tomcat /opt/tomcat
chmod +x /opt/tomcat/bin/*
echo 'export CATALINA_HOME=/opt/tomcat' >> ~/.bashrc
source ~/.bashrc
echo $CATALINA_HOME
$CATALINA_HOME/bin/startup.sh
apt install net-tools -y
netstat -plntu
