#!/bin/bash
#sudo apt update 
#sudo apt install -y httpd
#sudo systemctl start httpd
#sudo systemctl enable httpd
#echo "<h1>Hello World from $(hostname -f)</h1>" > /var/www/html/index.html

#!/bin/bash
sudo apt update 
sudo apt install nginx -y
sudo systemctl start nginx
sudo systemctl enable nginx
echo "<h1>Hello World from $(hostname -f)</h1>" > /var/www/html/index.html