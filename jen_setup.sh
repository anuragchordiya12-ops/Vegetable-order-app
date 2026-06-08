#!/bin/bash
set -e

echo "=== Step 1: Updating System ==="
dnf update -y

echo "=== Step 2: Installing Java 21 ==="
dnf install java-21-amazon-corretto -y
java -version

echo "=== Step 3: Adding Jenkins Repo ==="
wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key

echo "=== Step 4: Installing Jenkins ==="
dnf install jenkins -y

echo "=== Step 5: Setting JAVA_HOME for Jenkins ==="
mkdir -p /etc/systemd/system/jenkins.service.d
cat > /etc/systemd/system/jenkins.service.d/override.conf << EOF
[Service]
Environment="JAVA_HOME=/usr/lib/jvm/java-21-amazon-corretto.x86_64"
EOF

echo "=== Step 6: Starting Jenkins ==="
systemctl daemon-reload
systemctl start jenkins
systemctl enable jenkins
systemctl status jenkins

echo "=== Step 7: Installing Git ==="
dnf install git -y
git --version

echo "=== Step 8: Installing Maven ==="
dnf install maven -y
mvn -version

echo "=== Step 9: Installing Ansible ==="
dnf install ansible -y
ansible --version

echo "========================================"
echo "=== ALL DONE! Jenkins Unlock Password ==="
echo "========================================"
cat /var/lib/jenkins/secrets/initialAdminPassword

```bash
