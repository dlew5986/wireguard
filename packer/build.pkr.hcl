build {
  sources = ["source.amazon-ebs.wireguard"]

  provisioner "shell" {
    inline = [
      "sudo yum update -y",
      "sudo yum install nmap -y"
    ]
  }

  # install aws cli v2
  provisioner "shell" {
    inline = [
      "aws --version"
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
