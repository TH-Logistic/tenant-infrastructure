variable "instance_name" {
    description = "instance name"
    type = string
    default = "instance name"
}

variable "instance_ami" {
    type        = string
    description = "instance ami"
    default     = "ami-0aa2b7722dc1b5612"
}

variable "instance_type" {
    description = "instance type"
    type        = string
    default     = "t2.medium"
}

variable "instance_size" {
  description = "instance disk size"
  type = number
  default = 20
}

variable "key_pair_name" {
  description = "key pair name"
  type = string
}