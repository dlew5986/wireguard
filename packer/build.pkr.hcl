build {
  sources = ["source.amazon-ebs.wireguard"]

  # patch
  # install nmap
  provisioner "shell" {
    inline = [
      "sudo yum update -y",
      "sudo yum install -y nmap"
    ]
  }

  # remove aws cli v1
  # install aws cli v2
  provisioner "shell" {
    inline = [
      "sudo yum remove -y awscli",
      "curl \"https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip\" -o \"awscliv2.zip\"",
      "unzip -q awscliv2.zip",
      "sudo ./aws/install"
    ]
  }

  # install powershell
  provisioner "shell" {
    inline = [
      "curl \"https://packages.microsoft.com/config/rhel/7/prod.repo\" | sudo tee /etc/yum.repos.d/microsoft.repo",
      "sudo yum install -y powershell"
    ]
  }

  # # install aws.tools.installer module
  # provisioner "powershell" {
  #   #use_pwsh = true
  #   #elevated_user = root
  #   inline = [
  #     "whoami",
  #     "Get-Module -ListAvailable",
  #     #"Get-PSRepository -Name PSGallery | Set-PSRepository -InstallationPolicy Trusted",
  #     #"Install-Module -Name AWS.Tools.Installer -Scope AllUsers",
  #     #"Get-Module -ListAvailable"
  #   ]
  # }

  # install aws ssm agent
  provisioner "shell" {
    inline = [
      "yum info amazon-ssm-agent" # already baked into aws linux 2
    ]
  }

  # install aws cloudwatch agent
  provisioner "shell" {
    inline = [
      "sudo yum install -y amazon-cloudwatch-agent"
    ]
  }

}
