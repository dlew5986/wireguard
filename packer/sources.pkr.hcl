packer {
  required_plugins {
    amazon = {
      version = ">= 1.1.1"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "wireguard" {
  ami_name      = local.ami_name
  instance_type = "t2.micro"
  region        = "us-east-2"

  temporary_security_group_source_public_ip = true

  communicator = "ssh"
  ssh_username = "ec2-user"

  source_ami_filter {
    filters     = { name = "amzn2-ami-kernel-5.10-hvm-2.0.*-x86_64-gp2" }
    most_recent = true
    owners      = ["amazon"]
  }

  launch_block_device_mappings {
    delete_on_termination = true
    device_name           = "/dev/xvda"
    encrypted             = true
    volume_type           = "gp3"
  }

  tags            = local.tags
  run_tags        = local.tags
  run_volume_tags = local.tags
  snapshot_tags   = local.tags

}
