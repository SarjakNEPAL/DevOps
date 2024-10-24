# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # then creating webserver
  config.vm.define "web-server" do |web|
    web.vm.box = "ubuntu/focal64" #os used
    web.vm.hostname = "web-server" # name of the host
    web.vm.network "private_network",ip: '192.168.1.70'    
    web.vm.provision "shell", inline: <<-SHELL  
      # Update and install Apache, PHP, and other dependencies
      sudo apt-get update
      sudo apt-get install -y apache2 php libapache2-mod-php php-mysql curl ghostscript libapache2-mod-php php-bcmath php-curl php-imagick php-intl php-json php-mbstring php-xml php-zip
      
      # Download and install WordPress
      sudo mkdir -p /srv/www 
      sudo chown www-data: /srv/www
      curl -o /srv/www/latest.tar.gz https://wordpress.org/latest.tar.gz
      sudo -u www-data tar zx -C /srv/www -f /srv/www/latest.tar.gz
      sudo mv /srv/www/wordpress /srv/www/html
      
      # Configure Apache for WordPress
      echo '<VirtualHost *:80>
        DocumentRoot /srv/www/html
        <Directory /srv/www/html>
          Options FollowSymLinks
          AllowOverride Limit Options FileInfo
          DirectoryIndex index.php
          Require all granted
        </Directory>
        <Directory /srv/www/html/wp-content>
          Options FollowSymLinks
          Require all granted
        </Directory>
      </VirtualHost>' | sudo tee /etc/apache2/sites-available/wordpress.conf
       cd /etc/apache2/sites-available/
       rm 000-default.conf
rm default-ssl.conf
      sudo a2ensite wordpress
      sudo a2enmod rewrite

      
# wordpress and database connecting
sudo -u www-data cp /srv/www/wordpress/wp-config-sample.php /srv/www/wordpress/wp-config.php
    sudo -u www-data sed -i 's/database_name_here/wordpress/' /srv/www/wordpress/wp-config.php
    sudo -u www-data sed -i 's/username_here/wordpress/' /srv/www/wordpress/wp-config.php
    sudo -u www-data sed -i 's/password_here/1234567890/' /srv/www/wordpress/wp-config.php
    sudo -u www-data sed -i 's/localhost/192.168.1.100/' /srv/www/html/wp-config.php
    


    sudo systemctl restart apache2
    SHELL
  end



end
  