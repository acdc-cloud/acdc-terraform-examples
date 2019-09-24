#!/bin/bash

sudo apt-get -y update
sudo apt-get -y install nginx
sudo service nginx start

echo "<html><body>" > /var/www/html/index.html
echo "Welcome to the Arctic Cloud<br>Hostname: $HOSTNAME" >> /var/www/html/index.html
echo "</body></html>" >> /var/www/html/index.html
