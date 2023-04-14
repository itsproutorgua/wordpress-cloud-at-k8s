#! /usr/bin/env bash

# Configure WP-CLI
wp --allow-root --path=/var/www/html core install --url=$URL --title=$TITLE --admin_user=$ADMIN_USER --admin_password=$ADMIN_PASSWORD --admin_email=$ADMIN_EMAIL


wp plugin install contact-form-7 --activate
wp theme install twentyseventeen && wp theme activate twentyseventeen
wp theme list

