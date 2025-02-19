#!/bin/bash

# Run apt udate
sudo apt update

# Change the hostname to jenkins-master
sudo hostnamectl set-hostname jenkins-master

# Create a user called jenkins
sudo useradd -m -s /bin/bash jenkins

# Install Java 
sudo apt install openjdk-21-jdk -y

# Import the GPG key. The GPG key verifies package integrity.
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key

#Add the Jenkins software repository to the source list 
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
/etc/apt/sources.list.d/jenkins.list > /dev/null

# Update the packages in the repo
sudo apt update

# Install Jenkins
sudo apt install jenkins -y

# Check the status of Jenkins service
sudo systemctl status jenkins

# Enable firewall
sudo ufw enable

# Open port 8080 on the server
sudo ufw allow 8080

#sudo ufw status

# Get the initial admin password
sudo cat /var/lib/jenkins/secrets/initialAdminPassword > ~/jenkins-initial-password.txt

exit

# Download the file password file
#scp -i /path/my-key-pair.pem ubuntu@my-instance-public-dns-name:/path/to/file /local/path


