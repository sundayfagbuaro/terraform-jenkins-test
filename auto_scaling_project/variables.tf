variable "instance_count" {
  default = 2
}

output "instance_ips" {
  value = [for i in aws_autoscaling_group.app: i.id]
}

output "lb_dns" {
  value = aws_lb.app_lb.dns_name
}


data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

data "aws_ami" "latest_amazon_linux" {
  most_recent = true
  owners      = ["amazon"]
}

