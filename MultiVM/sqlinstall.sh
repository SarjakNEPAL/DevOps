      # Update and install MySQL server
      sudo apt-get update
      sudo apt-get install -y mysql-server
      sudo systemctl start mysql
      sudo systemctl enable mysql
      
    mysql -u root -e 'CREATE DATABASE wordpress;'
    mysql -u root -e 'CREATE USER "wordpress"@"%" IDENTIFIED BY "1234567890";'
    mysql -u root -e 'GRANT SELECT,INSERT,UPDATE,DELETE,CREATE,DROP,ALTER ON wordpress.* TO "wordpress"@"%";'
    mysql -u root -e 'FLUSH PRIVILEGES;'

    sudo sed -i 's/^bind-address.*/bind-address = 0.0.0.0/' /etc/mysql/mysql.conf.d/mysqld.cnf # Fixing the eroor of server refusing other remote acccess

    systemctl restart mysql