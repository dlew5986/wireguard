build {
  sources = ["source.amazon-ebs.wireguard"]

  provisioner "shell" {
    inline = [
      "sudo yum update -y",
      "sudo yum install nmap -y"
    ]
  }

  # install aws cli v2
  # install aws ssm agent
  # install aws cloudwatch agent

}
