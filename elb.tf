resource "aws_lb" "custom_lb" {
  name               = "custom-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.custom_sg.id]
  #  subnets            = ["${aws_subnet.public_subnet[0].id},${aws_subnet.public_subnet[1].id}"]
  subnets    = aws_subnet.public_subnet[*].id
  depends_on = [aws_internet_gateway.custom_gw]

  enable_deletion_protection = false

  tags = {
    Name = "custom_lb"
  }
}

resource "aws_lb_target_group" "custom_alb_target_group" {
  name        = "custom-lb-alb-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.custom_vpc.id
  target_type = "instance"

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }
}

resource "aws_lb_listener" "custom_listener" {
  load_balancer_arn = aws_lb.custom_lb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.custom_alb_target_group.arn
  }
}
