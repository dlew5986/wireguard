data "aws_ami" "source_ami" {
  most_recent = true
  owners      = ["self"]
  filter {
    name   = "name"
    values = [local.ami_regex]
  }
}

data "aws_key_pair" "wireguard" {
  key_name = local.key_pair_name
}

resource "aws_instance" "wireguard" {
  ami                    = data.aws_ami.source_ami.id
  instance_type          = local.instance_type
  key_name               = data.aws_key_pair.wireguard.key_name
  iam_instance_profile   = aws_iam_instance_profile.wireguard.name
  vpc_security_group_ids = [aws_security_group.wireguard.id]

  root_block_device {
    delete_on_termination = true
    encrypted             = true
    volume_type           = "gp3"
  }

  tags        = local.instance_tags
  volume_tags = local.instance_tags
}
