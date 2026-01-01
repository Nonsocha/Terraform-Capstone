#!/bin/bash
set -e

# Install dependencies
sudo dnf install -y amazon-efs-utils httpd php php-fpm php-mysqlnd php-cli php-common php-curl php-gd php-xml php-mbstring php-json php-zip php-bcmath || { echo "Failed to install packages"; exit 1; }

# Mount EFS
mkdir -p /var/www/html/
sudo mount -t efs -o tls,accesspoint=${efs_ap_id} ${efs_id}:/ /var/www/ || { echo "Failed to mount EFS"; exit 1; }

# Start services
sudo systemctl start httpd php-fpm
sudo systemctl enable httpd php-fpm

# Configure Apache for PHP-FPM
echo '<FilesMatch \.php$>
    SetHandler "proxy:fcgi://127.0.0.1:9000"
</FilesMatch>' > /etc/httpd/conf.d/php-fpm.conf

# Install WordPress
cd /tmp
wget http://wordpress.org/latest.tar.gz || { echo "Failed to download WordPress"; exit 1; }
tar xzvf latest.tar.gz
rm -rf latest.tar.gz
cp -R /tmp/wordpress/* /var/www/html/
cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php

# Create health check file
echo "OK" > /var/www/html/healthstatus

# Configure WordPress for RDS
sed -i "s/localhost/${rds_endpoint}/g" /var/www/html/wp-config.php
sed -i "s/username_here/${db_username}/g" /var/www/html/wp-config.php
sed -i "s/password_here/${db_password}/g" /var/www/html/wp-config.php
sed -i "s/database_name_here/${db_name}/g" /var/www/html/wp-config.php
# Set permissions
chown -R apache:apache /var/www/html/
chmod -R 755 /var/www/html/
chcon -R -t httpd_sys_rw_content_t /var/www/html/

# Restart services
sudo systemctl restart httpd php-fpm || { echo "Failed to restart services"; exit 1; }