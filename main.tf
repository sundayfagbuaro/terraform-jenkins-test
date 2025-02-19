provider "aws" {
  region = "eu-west-2"
}


resource "aws_launch_template" "app" {
  name_prefix   = "app-template-"
  image_id      = data.aws_ami.latest_amazon_linux.id
  instance_type = "t3.micro"
  network_interfaces {
    associate_public_ip_address = true
    security_groups = [aws_security_group.app_sg.id]
} 
}


resource "aws_autoscaling_group" "app" {
  vpc_zone_identifier = data.aws_subnets.default.ids
  desired_capacity      = 2
  max_size              = 5
  min_size              = 2
  health_check_type  = "ELB"
  launch_template {
    id      = aws_launch_template.app.id
    version = "$Latest"
} 
}

resource "aws_security_group" "app_sg" {
  name_prefix = "app-sg-"
  description = "Allow inbound traffic"

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks = ["0.0.0.0/0"]
} 
}


