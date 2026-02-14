output "instance_ipv4" {
  value = aws_instance.example-server.public_ip
}

output "instance_dns" {
  value = "http://${aws_instance.example-server.public_dns}"
}