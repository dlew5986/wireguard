locals {
  tags = {
    Name          = "wireguard_{{isotime}}"
    Project       = "wireguard_ami"
    source_ami_id = "?"
  }
}
