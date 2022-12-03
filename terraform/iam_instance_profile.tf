data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "wireguard" {
  name               = local.session_manager_role_name
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

resource "aws_iam_instance_profile" "wireguard" {
  name = local.session_manager_instance_profile_name
  role = aws_iam_role.wireguard.name
}

data "aws_iam_policy" "ssm_agent" {
  arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role_policy_attachment" "ssm_agent" {
  role       = aws_iam_role.wireguard.name
  policy_arn = data.aws_iam_policy.ssm_agent.arn
}

data "aws_iam_policy" "cloudwatch_agent" {
  arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

resource "aws_iam_role_policy_attachment" "cloudwatch_agent" {
  role       = aws_iam_role.wireguard.name
  policy_arn = data.aws_iam_policy.cloudwatch_agent.arn
}
