output "instance_username" {
  value = "centos"
}

output "server1_ip" {
  value = module.compute.server1_ip
}

output "server2_ip" {
  value = module.compute.server2_ip
}
