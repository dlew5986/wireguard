locals {
  ami_regex                             = "wireguard_*"
  instance_type                         = "t2.micro"
  key_pair_name                         = "wireguard"
  security_group_name                   = "wireguard"
  session_manager_role_name             = "wireguard"
  session_manager_instance_profile_name = "wireguard"

  tags = {
    Name    = "wireguard"
    Project = "wireguard_ami"
  }

}
