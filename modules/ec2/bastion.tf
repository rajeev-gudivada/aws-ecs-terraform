# Create the security groups to allow ssh ingress and all traffic out
resource "aws_security_group" "bastion_sg" {
  name        = "${var.app_name}-${var.app_environment}-bastion-sg"
  description = "Allow SSH inbound connections to Bastion host"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.app_name}-${var.app_environment}-bastion-sg"
  }
}

# Upload the keypair

resource "aws_key_pair" "bastion_key_pair" {
  key_name   = "${var.app_name}-${var.app_environment}-bastion-key"
  public_key = file(var.bastion_public_key_path)
}

# Bastion instance

resource "aws_instance" "bastion_instance" {
  ami                         = "ami-074dc0a6f6c764218"
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.bastion_key_pair.key_name
  vpc_security_group_ids      = [aws_security_group.bastion_sg.id]
  subnet_id                   = element(var.public_subnets_id,0)
  associate_public_ip_address = true

  tags = {
    Name = "ec2-${var.app_name}-${var.app_environment}-bastion"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y"
    ]
  }

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file(var.bastion_private_key_path)
    host        = self.public_ip
  }

}


