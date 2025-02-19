resource "aws_lb" "app_lb" {
  name               = "app-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  subnets           = data.aws_subnets.default.ids
}

resource "aws_lb_target_group" "app_tg" {
  name     = "app-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.default.id
}

resource "aws_lb_listener" "http" {
    load_balancer_arn = aws_lb.app_lb.arn
    port              = 80
    protocol          = "HTTP"
    default_action {
        type           = "forward"
        target_group_arn = aws_lb_target_group.app_tg.arn
    } 
}