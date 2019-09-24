#!/bin/bash

sudo apt-get -y update
sudo apt-get -y install nginx
sudo service nginx start

echo "<html><body>" > /var/www/html/index.html
echo "Welcome to the Arctic Cloud<br>" >> /var/www/html/index.html
echo "<iframe width="420" height="315"
src="https://www.youtube.com/embed/uD8_iMbzx7w">
</iframe></body></html>" >> /var/www/html/index.html
