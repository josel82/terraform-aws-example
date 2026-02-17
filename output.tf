output "instance_ipv4" {
  value = try(aws_spot_instance_request.cheap-server.public_ip, "Public IP not ready yet...")
}


output "instance_dns" {
  value = try("http://${aws_spot_instance_request.cheap-server.public_dns}", "Public DNS not ready yet...")
}
