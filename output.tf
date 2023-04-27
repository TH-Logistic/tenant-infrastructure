output "registry_ip" {
  description = "Registry public IP address"
  value       = module.instance_registry.public_ip
}

output "auth_ip" {
  description = "Auth public IP address"
  value       = module.instance_auth.public_ip
}

output "product_ip" {
  description = "Product public IP address"
  value       = module.instance_product.public_ip
}

output "orgarnization_ip" {
  description = "Orgarnization public IP address"
  value       = module.instance_orgarnization.public_ip
}

output "route_ip" {
  description = "Route public IP address"
  value       = module.instance_route.public_ip
}

output "user_ip" {
  description = "User public IP address"
  value       = module.instance_user.public_ip
}