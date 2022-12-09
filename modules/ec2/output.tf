output "bastion_sg" {
  description = "SG attached to the Bastion host"
  value       = aws_security_group.bastion_sg.id
}
