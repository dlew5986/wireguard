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
  volume_tags = merge(local.default_tags, local.instance_tags)
}

resource "aws_ec2_tag" "eni" {
  resource_id = aws_instance.wireguard.primary_network_interface_id
  for_each    = merge(local.default_tags, local.instance_tags)
  key         = each.key
  value       = each.value
}
