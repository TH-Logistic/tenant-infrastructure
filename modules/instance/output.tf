output "public_ip" {
  description = "public IP address of instance"
  value = aws_instance.instance.public_ip
}

output "instance_id" {
  description = "instance id"
  value = aws_instance.instance.id
}