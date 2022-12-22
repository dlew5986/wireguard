packer {
  required_plugins {
    amazon = {
      version = ">= 1.1.1"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

variable "github_branch" {
  type = string
}

variable "github_repo" {
  type = string
}

locals {
  timestamp = regex_replace(timestamp(), "[: ]", "-")
  ami_name  = "wireguard_${local.timestamp}"

  tags = {
    Name            = local.ami_name
    created_by      = "packer"
    github_branch   = var.github_branch
    github_repo     = var.github_repo
    packer_version  = "{{ packer_version }}"
    source_ami_id   = "{{ .SourceAMI }}"
    source_ami_name = "{{ .SourceAMIName }}"
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

build {
  sources = ["source.amazon-ebs.wireguard"]

  provisioner "shell" {
    script = "./provision.sh"
  }
}
