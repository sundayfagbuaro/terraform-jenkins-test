resource "aws_vpc" "custom_vpc" {
  cidr_block = "192.168.0.0/16"

  tags = {
    Name = "custom_vpc"
  }

}

resource "aws_subnet" "public_subnet" {
  count                   = length(var.azs)
  vpc_id                  = aws_vpc.custom_vpc.id
  cidr_block              = element(var.public_subnet_cidr_value, count.index)
  map_public_ip_on_launch = true # public subnet
  availability_zone       = element(var.azs, count.index)

  tags = {
    Name = "public_subnet-${count.index}"
  }

}

resource "aws_subnet" "private_subnet" {
  #    count = length(var.private_subnet_cidr_value)
  vpc_id                  = aws_vpc.custom_vpc.id
  cidr_block              = "192.168.30.0/24"
  map_public_ip_on_launch = false # private subnet
  availability_zone       = var.azs[0]

  tags = {
    Name = "private_subnet"
  }

}

resource "aws_internet_gateway" "custom_gw" {
  vpc_id = aws_vpc.custom_vpc.id

  tags = {
    Name = "custom_igw"
  }
}

# route table for public subnet - connecting to Internet gateway
resource "aws_route_table" "custom_route_public" {
  vpc_id = aws_vpc.custom_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.custom_gw.id
  }
  tags = {
    Name = "Public_Route_Table"
  }
}

#Associate the public subnets with the route table
resource "aws_route_table_association" "public" {
  count = length(var.public_subnet_cidr_value)

  subnet_id      = element(aws_subnet.public_subnet.*.id, count.index)
  route_table_id = aws_route_table.custom_route_public.id
}

resource "aws_nat_gateway" "custom_nat" {
  allocation_id = aws_eip.custom_eip.id
  subnet_id     = aws_subnet.public_subnet[0].id
  depends_on    = [aws_internet_gateway.custom_gw]

  tags = {
    Name = "Custom_nat"
  }

}

resource "aws_eip" "custom_eip" {
  depends_on = [aws_internet_gateway.custom_gw]
  domain     = "vpc"
  tags = {
    Name = "Custom_EIP_for_NAT"
  }
}

# route table - connecting to NAT
resource "aws_route_table" "custom_route_table_private" {
  vpc_id = aws_vpc.custom_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.custom_nat.id
  }
  depends_on = [aws_nat_gateway.custom_nat]

  tags = {
    Name = "private_route_table"
  }
}

# associate the route table with private subnet 1
resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.custom_route_table_private.id

  #  subnet_id      = "${element(aws_subnet.private_subnet.id, count.index)}"

}

# Create security groups for the load balancer
resource "aws_security_group" "custom_sg" {
  name   = "custom_sg"
  vpc_id = aws_vpc.custom_vpc.id

  ingress {
    description = "Allow http request from anywhere"
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

