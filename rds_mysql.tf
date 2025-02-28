provider "aws" {
  region = "eu-west-2"
}


# Create the rds instance
resource "aws_db_instance" "db_instance" {
  engine                 = "mysql"
#  engine_version         = "8.4.4"
  multi_az               = "false"
  identifier             = "dev-rds-instance"
  username               = "devopsuser"
  password               = "kloudvista2025"
  instance_class         = "db.t3.micro"
  allocated_storage      = "200"
  db_subnet_group_name   = aws_db_subnet_group.database_subnet_group.name
  vpc_security_group_ids = [aws_security_group.database_sg.id]
  availability_zone      = data.aws_availability_zones.availability_zones.names[0]
  db_name                = "applicationdb"
  skip_final_snapshot    = "true"

}