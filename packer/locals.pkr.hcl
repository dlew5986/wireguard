locals {

  ami_name = "wireguard_${formatdate("YYYY-MM-DD'T'hh-mm-ss'Z'", timestamp())}"

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
