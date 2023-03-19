packer {
  required_plugins {
    amazon = {
      version = ">= 1.1.1"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

variable "aws_region_to_build_in" {
  type = string
}

variable "aws_role_to_assume" {
  type = string
}

variable "github_branch" {
  type = string
}

variable "github_repo" {
  type = string
}

variable "skip_create_ami" {
  type = bool
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
  ami_name        = local.ami_name
  instance_type   = "t2.micro"
  region          = var.aws_region_to_build_in
  skip_create_ami = var.skip_create_ami

  assume_role {
    role_arn     = var.aws_role_to_assume
    session_name = "packer"
    external_id  = "packer"
  }

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

  communicator  = "ssh"
  ssh_interface = "session_manager"
  ssh_username  = "ec2-user"

  temporary_iam_instance_profile_policy_document {
    Version = "2012-10-17"
    Statement {
      Effect = "Allow"
      Action = [
        "ssm:DescribeAssociation",
        "ssm:GetDeployablePatchSnapshotForInstance",
        "ssm:GetDocument",
        "ssm:DescribeDocument",
        "ssm:GetManifest",
        "ssm:GetParameter",
        "ssm:GetParameters",
        "ssm:ListAssociations",
        "ssm:ListInstanceAssociations",
        "ssm:PutInventory",
        "ssm:PutComplianceItems",
        "ssm:PutConfigurePackageResult",
        "ssm:UpdateAssociationStatus",
        "ssm:UpdateInstanceAssociationStatus",
        "ssm:UpdateInstanceInformation"
      ]
      Resource = ["*"]
    }
    Statement {
      Effect = "Allow"
      Action = [
        "ssmmessages:CreateControlChannel",
        "ssmmessages:CreateDataChannel",
        "ssmmessages:OpenControlChannel",
        "ssmmessages:OpenDataChannel"
      ]
      Resource = ["*"]
    }
    Statement {
      Effect = "Allow"
      Action = [
        "ec2messages:AcknowledgeMessage",
        "ec2messages:DeleteMessage",
        "ec2messages:FailMessage",
        "ec2messages:GetEndpoint",
        "ec2messages:GetMessages",
        "ec2messages:SendReply"
      ]
      Resource = ["*"]
    }
  }
}

build {
  sources = ["source.amazon-ebs.wireguard"]

  provisioner "shell" {
    script = "./provision.sh"
  }
}
