locals {
  ami_regex                             = "wireguard_*"
  instance_type                         = "t2.micro"
  key_pair_name                         = "wireguard"
  security_group_name                   = "wireguard"
  session_manager_role_name             = "wireguard"
  session_manager_instance_profile_name = "wireguard"

  default_tags = {
    Name       = "wireguard"
    created_by = "terraform"
  }

  instance_tags = {
    source_ami_id   = data.aws_ami.source_ami.id
    source_ami_name = data.aws_ami.source_ami.name
  }

}
