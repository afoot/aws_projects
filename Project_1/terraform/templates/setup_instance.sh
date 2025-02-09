#!/usr/bin/env bash

# Update package lists
sudo apt update -y

# Install Java (OpenJDK)
sudo apt install -y default-jdk

# Create Tomcat user and group
sudo useradd -m -d /opt/tomcat -U -s /bin/false tomcat

# Download Tomcat (replace with the desired version)
TOMCAT_VERSION="10.1.34"  # Example version
wget "https://dlcdn.apache.org/tomcat/tomcat-10/v10.1.34/bin/apache-tomcat-10.1.34.tar.gz" -O tomcat.tar.gz

# Extract Tomcat to /opt/
sudo tar -xzf tomcat.tar.gz -C /opt/tomcat --strip-components=1

# Set file permissions
sudo chown -R tomcat:tomcat /opt/tomcat/
sudo chmod -R u+x /opt/tomcat/bin

# Configure Tomcat (tomcat-users.xml)
sudo nano /opt/tomcat/conf/tomcat-users.xml  # Add user with manager-gui role

# Configure Tomcat (server.xml - optional for remote access)
# sudo nano /opt/tomcat/conf/server.xml # Modify <Connector> if needed

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

# Enable and start Tomcat
sudo systemctl daemon-reload
sudo systemctl enable tomcat
sudo systemctl start tomcat

sudo ufw allow 8080
