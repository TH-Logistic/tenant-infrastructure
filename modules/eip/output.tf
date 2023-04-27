output "public_ip" {
  description = "instance public ip address"
  value = aws_eip.eip.public_ip
}