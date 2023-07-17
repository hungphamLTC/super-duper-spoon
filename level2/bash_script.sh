MYSQL_USER="{db_user}"
MYSQL_PASSWORD="{db_password}"
MYSQL_HOST="{db_endpoint}"

sudo apt update -y
sudo apt install -y apache2 \
                 ghostscript \
                 libapache2-mod-php \
                 mysql-server \
                 php \
                 php-bcmath \
                 php-curl \
                 php-imagick \
                 php-intl \
                 php-json \
                 php-mbstring \
                 php-mysql \
                 php-xml \
                 php-zip

sudo systemctl start apache2
sudo systemctl enable apache2
sudo systemctl start mysql
sudo systemctl enable mysql

sudo ufw allow 'Apache Full'

sudo mkdir /var/www/hungpham.link
sudo chown -R www-data.www-data /var/www/hungpham.link/
sudo chmod 755 /var/www/hungpham.link/
touch /var/www/hungpham.link/index.html
cd /etc/apache2/

touch sites-available/hungpham.link.conf

sudo tee /etc/apache2/sites-available/hungpham.link.conf > /dev/null <<EOF
<VirtualHost *:80>
    ServerName hungpham.link
    ServerAlias www.hungpham.link
    DocumentRoot /var/www/hungpham.link

    ServerAdmin webmaster@hungpham.link
    ErrorLog /var/log/apache2/hungpham_link_error.log
    CustomLog /var/log/apache2/hungpham_link_access.log combined
</VirtualHost>
EOF

sudo a2ensite hungpham.link
sudo a2dissite 000-default
sudo systemctl reload apache2


mysql -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" -h"$MYSQL_HOST" <<EOF
CREATE DATABASE wordpress;
CREATE USER 'wordpress'@'localhost' IDENTIFIED BY 'Pass123.';
GRANT ALL PRIVILEGES ON wordpress.* TO 'wordpress'@'localhost';
FLUSH PRIVILEGES;
exit
EOF

cd /tmp/
wget https://wordpress.org/latest.tar.gz
tar -xzvf latest.tar.gz
ls wordpress/
rm -rf /var/www/hungpham.link/*
mv wordpress/* /var/www/hungpham.link/
chown -R www-data.www-data /var/www/hungpham.link/
