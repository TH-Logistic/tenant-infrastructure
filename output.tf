output "registry_ip" {
  description = "Registry public IP address"
  value       = module.instance_registry.public_ip
}

output "auth_ip" {
  description = "Auth public IP address"
  value       = module.instance_auth.public_ip
}

