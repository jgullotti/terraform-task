output "instance_username" {
  value = "centos"
}

output "instance_public_ips" {
  value = module.compute.instance_public_ips
}

output "ssh_identity" {
  value = var.pubkey_path
}
