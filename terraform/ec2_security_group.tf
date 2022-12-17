resource "aws_security_group" "wireguard" {
  name   = local.security_group_name
  vpc_id = data.aws_vpc.vpc_default.id

  # allow ICMPv4 echo
  ingress {
    description = "ICMPv4 echo"
    from_port   = 8
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # allow all outbound
  egress {
    description = "all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
