output "key_pair_name" {
  description = "Contains the public IP address"
  value       = aws_key_pair.key_pair.key_name
}