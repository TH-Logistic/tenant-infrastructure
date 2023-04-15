output "aws_instances" {
  value       = aws_instance.th-ec2.*.public_ip
  description = "Public IP of instance"
}