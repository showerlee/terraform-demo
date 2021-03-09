resource "aws_vpc" "tf_demo_vpc" {
  cidr_block = var.vpc.cidr

  tags = {
    Name = "${var.app_name}-vpc"
  }
}

resource "aws_subnet" "tf_demo_subnet" {
  vpc_id            = aws_vpc.tf_demo_vpc.id
  cidr_block        = var.subnet.cidr
  availability_zone = var.availability_zone

  tags = {
    Name = "${var.app_name}-subnet"
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
