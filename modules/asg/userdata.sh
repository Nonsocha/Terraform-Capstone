#!/bin/bash
set -euxo pipefail

########################################
# UPDATE SYSTEM
########################################
sudo apt-get update -y

########################################
# INSTALL DEPENDENCIES
########################################
sudo apt-get install -y \
  apache2 \
  php \
  libapache2-mod-php \
  php-mysql \
  php-curl \
  php-gd \
  php-mbstring \
  php-xml \
  php-xmlrpc \
  php-soap \
  php-intl \
  php-zip \
  php-fpm \
  unzip \
  curl \
  wget \
  nfs-common
  
########################################
# INSTALL BUILD DEPENDENCIES (EFS)
########################################
sudo apt-get install -y \
  git \
  binutils \
  rustc \
  cargo \
  pkg-config \
  libssl-dev \
  make \
  build-essential \
  cmake \
  golang 

########################################
# DOWNLOAD & BUILD EFS UTILS
########################################
cd /tmp

git clone https://github.com/aws/efs-utils.git
cd efs-utils

sudo make deb

########################################
# INSTALL EFS UTILS
########################################
sudo apt-get install -y ./build/amazon-efs-utils*deb 

sudo systemctl enable apache2
sudo systemctl start apache2

########################################
# MOUNT EFS ACCESS POINT
########################################
# create wordpress directory
mkdir -p /var/www/html
########

# WAIT FOR EFS TO BECOME AVAILABLE
echo "Waiting for EFS mount target..."

for i in {1..30}; do
mount -t efs -o tls,accesspoint=${access_point} ${efs_id}:/ /var/www/html && break
echo "EFS not ready yet. Retrying..."
sleep 10
done

# PERSIST EFS MOUNT
echo "${efs_id}:/ /var/www/html efs _netdev,tls,accesspoint=${access_point} 0 0" >> /etc/fstab

########################################
# DOWNLOAD WORDPRESS
########################################

cd /tmp/
wget https://wordpress.org/latest.tar.gz
tar -xzf latest.tar.gz
# rm -f latest.tar.gz

########################################
# SETUP WORDPRESS
########################################

mkdir -p /var/www/html
cp -R wordpress/* /var/www/html/

cd /var/www/html
cp wp-config-sample.php wp-config.php

########################################
# CONFIGURE DATABASE
########################################

sed -i "s/localhost/${rds_endpoint}/g" wp-config.php
sed -i "s/username_here/${db_user}/g" wp-config.php
sed -i "s/password_here/${db_password}/g" wp-config.php
sed -i "s/database_name_here/${db_name}/g" wp-config.php

########################################
# PERMISSIONS
########################################

chown -R www-data:www-data /var/www/html
find /var/www/html -type d -exec chmod 755 {} \;
find /var/www/html -type f -exec chmod 644 {} \;

########################################
# HEALTH CHECK FILE
########################################

touch healthstatus

########################################
# ENABLE APACHE MOD REWRITE
########################################

a2enmod rewrite
sudo systemctl restart apache2

echo "WordPress setup completed"