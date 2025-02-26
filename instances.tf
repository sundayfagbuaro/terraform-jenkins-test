resource "aws_launch_template" "app" {
  name_prefix   = "app-template-"
  image_id      = var.ami_id
  instance_type = var.instance_type_value
  network_interfaces {
    associate_public_ip_address = true
    #    associate_public_ip_address = false
    security_groups = [aws_security_group.custom_sg.id]
  }
  user_data = filebase64("user_data.sh")

  tags = {
    Name = "Web-Server"
  }
}


resource "aws_autoscaling_group" "app" {
  #  vpc_zone_identifier = ["${aws_subnet.public_subnet[0].id},${aws_subnet.public_subnet[1].id}"]
  vpc_zone_identifier = aws_subnet.public_subnet[*].id
  desired_capacity    = 2
  max_size            = 5
  min_size            = 2
  target_group_arns   = [aws_lb_target_group.custom_alb_target_group.arn]
  health_check_type   = "EC2"

  launch_template {
    id      = aws_launch_template.app.id
    version = "$Latest"
  }

}
