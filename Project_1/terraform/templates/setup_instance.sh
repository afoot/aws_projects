#!/usr/bin/env bash

# Update the package list
sudo apt-get update

# Install required dependencies, including Java
sudo apt-get install -y unzip curl default-jdk

# Download the AWS CLI version 2 installer
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

# Unzip the installer
unzip awscliv2.zip

# Run the installer
sudo ./aws/install

# Clean up
rm -rf awscliv2.zip aws

# Create Tomcat user and group
sudo useradd -m -d /opt/tomcat -U -s /bin/false tomcat

# Download Tomcat (replace with the desired version)
TOMCAT_VERSION="10.1.34"  # Example version
wget "https://archive.apache.org/dist/tomcat/tomcat-10/v10.1.34/bin/apache-tomcat-10.1.34.tar.gz" -O tomcat.tar.gz

# Extract Tomcat to /opt/
sudo tar -xzf tomcat.tar.gz -C /opt/tomcat --strip-components=1

# Set file permissions
sudo chown -R tomcat:tomcat /opt/tomcat/
sudo chmod -R u+x /opt/tomcat/bin

# Systemd service file
sudo tee /etc/systemd/system/tomcat.service > /dev/null <<EOF
[Unit]
Description=Apache Tomcat ${TOMCAT_VERSION}
After=network.target

[Service]
User=tomcat
Group=tomcat
Type=forking
Environment="CATALINA_PID=/opt/tomcat/temp/tomcat.pid"
Environment="JAVA_HOME=/usr/lib/jvm/java-1.11.0-openjdk-amd64"
ExecStart=/opt/tomcat/bin/catalina.sh start
ExecStop=/opt/tomcat/bin/catalina.sh stop

[Install]
WantedBy=multi-user.target
EOF

# Replace the default ROOT webapp with the application
sudo rm -rf /opt/tomcat/webapps/ROOT
aws s3 cp s3://s3-for-artifacts-1221/vprofile-v2.war /tmp/vprofile-v2.war
sudo mv /tmp/vprofile-v2.war /opt/tomcat/webapps/ROOT.war

# Enable and start Tomcat
sudo systemctl daemon-reload
sudo systemctl enable tomcat
sudo systemctl start tomcat

# Allow traffic on port 8080
sudo ufw allow 8080
