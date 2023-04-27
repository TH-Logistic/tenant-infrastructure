# Defined resources for ec2 to run and expose port to the out side word.
# Refer to the image.png file. These resources will be placed from inside to outside
# Start with EC2 -> Security Group -> Subnet
# -> Route_Table_association (1-n table)inside n-n relationship between  route table & subnet
# -> VPC -> Internet gateway

resource "aws_instance" "instance" {
  ami                    = var.instance_ami
  instance_type          = var.instance_type
  key_name               = var.key_pair_name
  user_data              = file("./scripts/ec2-user-data-ubuntu.sh")
  vpc_security_group_ids = [aws_security_group.public_security.id]
  subnet_id              = aws_subnet.public_subnet.id
  tags = {
    "Name" = var.instance_name
  }
  root_block_device {
    volume_size = var.instance_size
  }
}

resource "aws_security_group" "public_security" {
  vpc_id = aws_vpc.public_vpc.id

  egress {
    description = "Any outbound allowed"
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress = [
    {
      cidr_blocks      = ["0.0.0.0/0", ]
      description      = "Allow any traffic from client"
      from_port        = 0
      to_port          = 65535
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
    }
  ]
}

resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.public_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1b"

  map_public_ip_on_launch = true
}

resource "aws_route_table_association" "rta" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.to_internet_gateway.id
}

resource "aws_route_table" "to_internet_gateway" {
  vpc_id = aws_vpc.public_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }
}

resource "aws_vpc" "public_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.public_vpc.id
}

# Elastic IP

resource "aws_eip" "eip" {
  instance = aws_instance.instance.id
  vpc      = true
}

