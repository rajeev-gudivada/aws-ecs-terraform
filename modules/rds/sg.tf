resource "aws_security_group" "rds_sg" {
  vpc_id = var.vpc_id

  ingress {
    protocol        = "tcp"
    from_port       = 3306
    to_port         = 3306
    cidr_blocks     = ["0.0.0.0/0"]
    security_groups = [var.ecs_sg]
  }

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

    tags = {
    Name        = "sg-${var.app_name}-${var.app_environment}-rds"
    Environment = var.app_environment
  }
}