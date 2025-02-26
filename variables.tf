variable "azs" {
  default = ["eu-west-2a", "eu-west-2b"]
  type    = list(string)

}

variable "public_subnet_cidr_value" {
  default = ["192.168.1.0/24", "192.168.2.0/24"]
  type    = list(string)

}

variable "private_subnet_cidr_value" {
  default = ["192.168.30.0/24"]
  type    = list(string)


}

variable "instance_count" {
  default = 2
}

variable "ami_id" {
  default = "ami-091f18e98bc129c4e"
}

variable "instance_type_value" {
  default = "t2.micro"
}

/*
output "instance_ips" {
  value = [for i in aws_autoscaling_group.app: i.id]
}
*/

output "alb_dns_name" {
  description = "The DNS name of ALB"
  value       = aws_lb.custom_lb.dns_name

}

