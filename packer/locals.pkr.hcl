locals {

  ami_name = "wireguard_${formatdate("YYYY-MM-DD'T'hh-mm-ss'Z'", timestamp())}"

  tags = {
    Name           = local.ami_name
    packer_version = "{{ packer_version }}"
    #source_ami_id   = "{{ .SourceAMI }}"
    #source_ami_name = "{{ .SourceAMIName }}"

  }
}
