# Create a new security group
# If not specified it will attach to the default VPC
resource "aws_security_group" "example-sg" {
    name = "example-sg"
    description = "Security group for example deployment"

    tags = {
      Name = "example-sg"
    }
}

# Allow SSH rule
resource "aws_vpc_security_group_ingress_rule" "allow-ssh-rule" {
  security_group_id = aws_security_group.example-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

# Allow HTTP rule
resource "aws_vpc_security_group_ingress_rule" "allow-http-rule" {
  security_group_id = aws_security_group.example-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

# Allow everything outbound
resource "aws_vpc_security_group_egress_rule" "allow-all-traffic" {
  security_group_id = aws_security_group.example-sg.id
  cidr_ipv4 = "0.0.0.0/0"
  ip_protocol = -1
}