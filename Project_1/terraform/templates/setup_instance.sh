#!/usr/bin/env bash

# Update package lists
sudo apt update -y

# Install Java (OpenJDK)
sudo apt install -y default-jdk

# Create Tomcat user and group
sudo groupadd tomcat
sudo useradd -s /bin/false -g tomcat tomcat

# Download Tomcat (replace with the desired version)
TOMCAT_VERSION="10.1.15"  # Example version
wget "https://downloads.apache.org/tomcat/tomcat-${TOMCAT_VERSION}/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz" -O tomcat.tar.gz

# Extract Tomcat to /opt/
sudo tar -xzf tomcat.tar.gz -C /opt/
sudo ln -s /opt/apache-tomcat-${TOMCAT_VERSION} /opt/tomcat

# Set file permissions
sudo chown -R tomcat:tomcat /opt/tomcat
sudo chmod +x /opt/tomcat/bin/*.sh

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
PIDFile=/opt/tomcat/temp/catalina.pid
Environment=JAVA_HOME=$(update-alternatives --query java | grep "link" | awk '{print $2}') # Dynamically find JAVA_HOME
ExecStart=/opt/tomcat/bin/catalina.sh start
ExecStop=/opt/tomcat/bin/catalina.sh stop

[Install]
WantedBy=multi-user.target
EOF

# Enable and start Tomcat
sudo systemctl daemon-reload
sudo systemctl enable tomcat
sudo systemctl start tomcat

echo "Tomcat installation complete. Access Tomcat at http://your_server_ip:8080"
echo "Remember to configure a firewall and HTTPS!"