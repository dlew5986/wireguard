build {
  sources = ["source.amazon-ebs.wireguard"]

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

  # install aws ssm agent
  provisioner "shell" {
    inline = [
      "yum info amazon-ssm-agent"
    ]
  }

  # install aws cloudwatch agent

}
