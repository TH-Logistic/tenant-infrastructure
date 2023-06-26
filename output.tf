output "mongo_ip" {
  description = "Auth public IP address"
  value       = module.instance_mongo.public_ip
}

output "rds_ip" {
  description = "RDS public IP Address"
  value       = module.instance_rds.rds_ip
}

output "rds_port" {
  description = "RDS public IP Address"
  value       = module.instance_rds.rds_port
}

output "auth_ip" {
  description = "Auth public IP address"
  value       = module.instance_auth.public_ip
}

output "product_ip" {
  description = "Product public IP address"
  value       = module.instance_product.public_ip
}

output "organization_ip" {
  description = "Orgarnization public IP address"
  value       = module.instance_organization.public_ip
}

output "route_ip" {
  description = "Route public IP address"
  value       = module.instance_route.public_ip
}

output "healthcheck_ip" {
  description = "Healthcheck public IP address"
  value       = module.instance_healthcheck.public_ip
}

output "job_ip" {
  description = "Job public IP address"
  value       = module.instance_job.public_ip
}

output "billing_ip" {
  description = "Billing public IP address"
  value       = module.instance_billing.public_ip
}

output "mail_ip" {
  description = "Mailing public IP address"
  value       = module.instance_mail.public_ip
}

output "user_ip" {
  description = "User public IP address"
  value       = module.instance_user.public_ip
}

output "gateway_ip" {
  description = "Gateway public IP address"
  value       = module.instance_gateway.public_ip
}
