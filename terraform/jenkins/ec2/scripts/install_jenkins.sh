#! /bin/bash
wget -q -O - https://pkg.jenkins.io/debian/jenkins-ci.org.key | sudo apt-key add -
echo deb https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list
deb https://pkg.jenkins.io/debian-stable binary/
        sudo apt-get update
sudo apt-get install openjdk-8-jdk jenkins -y
		sudo systemctl start jenkins
		echo "<h1>Deployed via Terraform</h1>" | sudo tee /var/www/html/index.html