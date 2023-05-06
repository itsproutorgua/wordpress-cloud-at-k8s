#!/bin/sh

mysql -h $SERVER_NAME -u $USER_NAME -p$PASSWORD -P 3306 -e "\
   CREATE DATABASE IF NOT EXISTS test_manifest12; \
    USE test_manifest12; \
    CREATE TABLE IF NOT EXISTS my_table (id INT PRIMARY KEY, name VARCHAR(50)); \
    INSERT IGNORE INTO my_table (id, name) VALUES (1, 'John'), (2, 'Jane'), (3, 'Joe');" 
if [  -f /var/www/html/wp-config.php ]; then  
    wp --allow-root --path=/var/www/html plugin install contact-form-7 --activate && \
    wp --allow-root --path=/var/www/html theme install hestia    && \
    wp --allow-root --path=/var/www/html theme activate hestia     
else    
    # Configure WP-CLI and install plugins and themes
    wp core download --path=/var/www/html --allow-root && \
    wp --allow-root --path=/var/www/html config create \
      --dbhost=mysql-wpmaximus.mysql.database.azure.com \
      --dbname=test_manifest12 \
      --dbuser=mysqladmin@mysql-wpmaximus \
      --dbpass=1-qwerty \
      --allow-root && \
    wp --allow-root --path=/var/www/html core install \
      --url=http://techspace.tech/  \
      --title=WPsite \
      --admin_user=admin \
      --admin_password=admin \
      --admin_email=admin@example.com && \
    wp --allow-root --path=/var/www/html plugin install contact-form-7 --activate && \
    wp --allow-root --path=/var/www/html theme install twentytwentytwo  && \
    wp --allow-root --path=/var/www/html theme activate twentytwentytwo     
fi

