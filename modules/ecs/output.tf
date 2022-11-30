output "ecs_sg" {
  description = "SG attached to the ECS"
  value       = aws_security_group.service_security_group.id
}
