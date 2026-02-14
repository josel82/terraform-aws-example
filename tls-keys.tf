

resource "tls_private_key" "tf-key-pair" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "tf-public-key" {
  key_name   = "tf-example"
  public_key = tls_private_key.tf-key-pair.public_key_openssh
}

resource "local_file" "tf-private-key" {
  content  = tls_private_key.tf-key-pair.private_key_pem
  filename = "tf-example"
}


