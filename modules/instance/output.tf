output "public_ip" {
  description = "public IP address of instance"
  value = aws_instance.instance.public_ip
}

# output "instance_ip" {
#   description = "public IP assress of instance"
#   value = aws_instance.instance.public_ip
# }