output "public_ip" {
  description = "public IP address of instance"
  value       = aws_eip.eip.public_ip
}