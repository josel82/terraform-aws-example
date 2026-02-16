# Configure the AWS Provider
provider "aws" {
  region  = "eu-west-1"
  profile = "terraform-user"
}

# Fetch information about the latest Amazon Linux 2023 AMI
data "aws_ami" "amazon_linux_2023" {
  most_recent = true

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-kernel-6.1-x86_64"]
  }

  owners = [137112412989]
}



resource "aws_instance" "example-server" {
  ami                         = data.aws_ami.amazon_linux_2023.id
  instance_type               = var.instance_type
  associate_public_ip_address = true
  security_groups             = [aws_security_group.example-sg.name]
  key_name                    = aws_key_pair.tf-public-key.key_name
  user_data                   = file("instance-init.sh")
  iam_instance_profile        = aws_iam_instance_profile.iam-ro-inst-pfl.name

  tags = {
    Name = "example-server"
  }
}

