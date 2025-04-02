wget https://dlcdn.apache.org/maven/maven-3/3.9.9/binaries/apache-maven-3.9.9-bin.tar.gz
tar -xvf apache-maven-3.9.9-bin.tar.gz
mv apache-maven-3.9.9 /opt/
echo 'M2_HOME='/opt/apache-maven-3.9.9'' >>  ~/.bashrc
echo 'PATH="$M2_HOME/bin:$PATH"' >>  ~/.bashrc
echo 'export PATH' >>  ~/.bashrc
source ~/.bashrc
mvn -version
