#!/usr/bin/env bash

# -e Fail and exit script on any errors
# -x Print and expand each command
set -ex

# patch
#sudo yum update -y

# install nmap
sudo yum install -y nmap

# remove awscli v1
sudo yum remove -y awscli

# install awscli v2
curl 'https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip' -o 'awscliv2.zip'
unzip -q awscliv2.zip
sudo ./aws/install

# install powershell
curl 'https://packages.microsoft.com/config/rhel/8/prod.repo' | sudo tee '/etc/yum.repos.d/microsoft.repo'
sudo yum install -y powershell

# # install aws powershell modules
sudo pwsh -Command 'Set-PSRepository -Name PSGallery -InstallationPolicy Trusted;Install-Module -Name AWS.Tools.Installer -Scope AllUsers;Get-Module -ListAvailable'

# install aws ssm agent
# already baked into aws linux 2
yum info amazon-ssm-agent

# install aws cloudwatch agent
sudo yum install -y amazon-cloudwatch-agent
