# alb.tf | Load Balancer Configuration
# Craete external ALB in the public subnets to load balance traffic to the ECS containers
resource "aws_alb" "application_load_balancer" {
  name               = "alb-${var.app_name}-${var.app_environment}"
  internal           = false
  load_balancer_type = "application"
  subnets            = var.public_subnets
  security_groups    = [aws_security_group.load_balancer_security_group.id]

  tags = {
    Name        = "alb-${var.app_name}-${var.app_environment}"
    Environment = var.app_environment
  }
}

resource "aws_security_group" "load_balancer_security_group" {
  vpc_id = var.vpc_id

  ingress {
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name        = "sg-${var.app_name}-${var.app_environment}-alb"
    Environment = var.app_environment
  }
}

resource "aws_lb_target_group" "target_group" {
  name        = "tg-${var.app_name}-${var.app_environment}-api"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id

  health_check {
    healthy_threshold   = "3"
    interval            = "300"
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "3"
    path                = "/v1/healthcheck"
    unhealthy_threshold = "2"
  }

  tags = {
    Name        = "tg-${var.app_name}-${var.app_environment}-api"
    Environment = var.app_environment
  }
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_alb.application_load_balancer.id
  port              = "80"
  protocol          = "HTTP"

   default_action {
     type             = "forward"
     target_group_arn = aws_lb_target_group.target_group.id
   }

  #default_action {
  #  type = "redirect"

  #  redirect {
  #    port        = "443"
  #    protocol    = "HTTPS"
  #    status_code = "HTTP_301"
  #  }
  #}
}
/*
# Enable HTTPS
resource "aws_lb_listener" "listener-https" {
  load_balancer_arn = aws_alb.application_load_balancer.id
  port              = "443"
  protocol          = "HTTPS"

  ssl_policy      = "ELBSecurityPolicy-2016-08"
  certificate_arn = "<certificate-arn>"

  default_action {
    target_group_arn = aws_lb_target_group.target_group.id
    type             = "forward"
  }
}
*/