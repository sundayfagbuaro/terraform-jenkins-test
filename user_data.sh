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
#echo "<h1>Hello World from $(hostname -f)</h1>" > /var/www/html/index.html
echo "<!DOCTYPE html>
<head>
    <title>Terraform-Jenkins-Test</title>
    <style>
		body{background-color:powderblue; text-align: center;}
        div{text-align: center; background-origin: padding-box; background: fixed; 
            background-position: 50; background-color: aliceblue;
            border-radius: 50;
        }
	</style> 
</head>
<body class="body">
    <div class="div">
    <h1>Welcome To Kloud Vista DevOps Class</h1>
    </div><br>

    <div>
        <p><h1>Hello World from <strong>$(hostname -f)</strong></h1></p>
        <p>We are testing Autoscaling Group With Terraform and Jenkins</p>
    </div>

</body>" > /var/www/html/index.html