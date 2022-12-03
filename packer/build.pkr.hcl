build {
  sources = ["source.amazon-ebs.wireguard"]

  provisioner "shell" {
    inline = [
      "sudo yum update -y",
      "sudo yum install nmap -y"
    ]
  }

  # remove aws cli v1
  # install aws cli v2
  provisioner "shell" {
    inline = [
      "sudo yum remove awscli -y",
      "curl \"https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip\" -o \"awscliv2.zip\"",
      "unzip -q awscliv2.zip",
      "sudo ./aws/install"
    ]
  }

  # install powershell

  # install aws ssm agent
  provisioner "shell" {
    inline = [
      "yum info amazon-ssm-agent"
    ]
  }

  # install aws cloudwatch agent

}
