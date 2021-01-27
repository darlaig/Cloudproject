# Application load balancer 

resource "aws_lb" "alb" {
  name               = var.alb_attributes[0]
  internal           = var.alb_attributes[1]
  load_balancer_type = var.alb_attributes[2]
  ip_address_type    = var.alb_attributes[3]
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = [aws_subnet.public.id, aws_subnet.public1.id]


  tags = {
    Environment = "darl-production"
  }
}

# Load Balancer listener 

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.webgroup.arn
  }
}

# Load balancer Target Group

resource "aws_lb_target_group" "webgroup" {
  health_check {
    interval            = 10
    path                = "/"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }


  name        = "darl-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = aws_vpc.dalovpc.id
}


# Target group attachment 

resource "aws_lb_target_group_attachment" "targetgroup1" {
  target_group_arn = aws_lb_target_group.webgroup.arn
  target_id        = aws_instance.web1.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "targetgroup2" {
  target_group_arn = aws_lb_target_group.webgroup.arn
  target_id        = aws_instance.web2.id
  port             = 80
}