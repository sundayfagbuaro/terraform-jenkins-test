# Create default vpc if it does not exist
resource "aws_default_vpc" "default_vpc" {

    tags = {
      Name = "default_vpc"
    } 
} 

# Create default subnet 1 if it does not exist
resource "aws_default_subnet" "subnet_az1" {
    availability_zone = data.aws_availability_zones.availability_zones.names[0]
  
}

# Create second default subnet if it does not exist
resource "aws_default_subnet" "subnet_az2" {
    availability_zone = data.aws_availability_zones.availability_zones.names[1]
  
}

# Create database subnet group for the rds instance
resource "aws_db_subnet_group" "database_subnet_group" {
    name        = "database-subnets"
    subnet_ids  = [aws_default_subnet.subnet_az1.id, aws_default_subnet.subnet_az2.id]
    description = "subnets foir database instance"

    tags = {
        Name = "database_subnet_group"
    }
}

# Create security group for the database
resource "aws_security_group" "database_sg" {
  name        = "database_security_group"
  description = "Enable mysql/aurora access on port 3306"
  vpc_id      = aws_default_vpc.default_vpc.id

  ingress {
    description     = "mysql/aurora access"
    protocol        = "tcp"
    from_port       = 3306
    to_port         = 3306
    security_groups = [aws_security_group.custom_security_group.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "database_security_group"
  }
}

# security group for webserver
resource "aws_security_group" "custom_security_group" {
  name        = "custom_security_group"
  description = "Enable http traffic"
  vpc_id      = aws_default_vpc.default_vpc.id

  ingress {
    description = "allow-http"
    protocol    = "tcp"
    from_port   = 8080
    to_port     = 8080
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "allow-http"
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "allow-https"
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "allow-ssh"
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "custom_security_group"
  }
}