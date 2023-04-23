output "elastic_public_ip" {
  description = "Contains the public IP address"
  value       = aws_eip.th_eip.public_ip
}