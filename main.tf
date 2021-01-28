resource "aws_vpc" "tf_demo_vpc" {
  cidr_block = var.vpc.cidr

  tags = {
    Name = "${var.app_name}_vpc"
  }
}

resource "aws_subnet" "tf_demo_subnet" {
  vpc_id            = aws_vpc.tf_demo_vpc.id
  cidr_block        = var.subnet.cidr
  availability_zone = var.availability_zone

  tags = {
    Name = "${var.app_name}_subnet"
  }
}

resource "aws_route_table" "tf_demo_route_table" {
  vpc_id = aws_vpc.tf_demo_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tf_demo_gw.id
  }
}

resource "aws_route_table_association" "tf_demo_route_table_association" {
  subnet_id      = aws_subnet.tf_demo_subnet.id
  route_table_id = aws_route_table.tf_demo_route_table.id
}

resource "aws_internet_gateway" "tf_demo_gw" {
  vpc_id = aws_vpc.tf_demo_vpc.id
}

resource "aws_security_group" "tf_demo_sg" {
  name   = "${var.app_name}_security_group"
  vpc_id = aws_vpc.tf_demo_vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "tf_demo_ec2" {
  count                       = var.ec2.instance_count
  ami                         = var.ec2.ami
  instance_type               = var.ec2.instance_type
  vpc_security_group_ids      = [aws_security_group.tf_demo_sg.id]
  subnet_id                   = aws_subnet.tf_demo_subnet.id
  key_name                    = var.ec2.key_name
  associate_public_ip_address = true

  root_block_device {
    volume_type           = var.ec2.volume_type
    volume_size           = var.ec2.volume_size
    delete_on_termination = true
  }

  tags = {
    Name = "${var.app_name}_ec2"
  }
  depends_on = [aws_vpc.tf_demo_vpc, aws_subnet.tf_demo_subnet, aws_security_group.tf_demo_sg]
}
