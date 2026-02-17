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

# Spot Instance Request
resource "aws_spot_instance_request" "cheap-server" {
  ami = data.aws_ami.amazon_linux_2023.id
  instance_type = var.instance_type
  associate_public_ip_address = true
  security_groups = [ aws_security_group.example-sg.name ]
  key_name = aws_key_pair.tf-public-key.key_name
  user_data = file("instance-init.sh")

  spot_price = "0.017"
  spot_type = "one-time" 
  wait_for_fulfillment = true #Tell terraform to wait until the request is fulfilled to finish the apply
  tags = {
    Name = "CheapServer"
  }
}

# On-Demand instance
/*
resource "aws_instance" "example-server" {
  ami                         = data.aws_ami.amazon_linux_2023.id
  instance_type               = var.instance_type
  associate_public_ip_address = true
  security_groups             = [aws_security_group.example-sg.name]
  key_name                    = aws_key_pair.tf-public-key.key_name
  user_data                   = file("instance-init.sh")

  tags = {
    Name = "example-server"
  }
}

*/