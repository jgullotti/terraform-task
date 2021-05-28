output "instance_public_ips" {
  value = { for instance in aws_instance.servers : instance.tags["Name"] => instance.public_ip }
}
