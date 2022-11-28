resource "aws_db_subnet_group" "mysql-subnet-group" {
  name       = "rds-${var.app_name}-${var.app_environment}-subnet-group"
  subnet_ids = var.persistence_private_subnets_id
}

# creating RDS instance
resource "aws_db_instance" "mysql" {
  identifier                = "rds-${var.app_name}-${var.app_environment}"
  allocated_storage         = 5
  backup_retention_period   = 2
  backup_window             = "01:00-01:30"
  maintenance_window        = "sun:03:00-sun:03:30"
  multi_az                  = true
  engine                    = "mysql"
  engine_version            = "5.7"
  instance_class            = "db.t2.micro"
  name                      = "${var.app_name}_db"
  username                  = "${var.dbuser}"
  password                  = "${var.dbpassword}"
  port                      = "3306"
  db_subnet_group_name      = aws_db_subnet_group.mysql-subnet-group.name
  vpc_security_group_ids    = [aws_security_group.rds_sg.id, var.ecs_sg]
  skip_final_snapshot       = true
  final_snapshot_identifier = "worker-final"
  publicly_accessible       = true
}