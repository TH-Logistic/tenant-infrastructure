variable "aws_instance_ami" {
  type        = string
  description = "instance ami"
  default     = "ami-0aa2b7722dc1b5612"
}

variable "aws_instance_type" {
  description = "instance type"
  type        = string
  default     = "t3.medium"
}