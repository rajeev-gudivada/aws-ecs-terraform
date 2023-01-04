# rstudio server
resource "aws_instance" "rstudio" {
  ami = "${lookup(var.images, var.region)}"

  # free tier eligible
  instance_type = "${var.instance_type}"

  # list of security groups for the instance
  vpc_security_group_ids = [
    aws_security_group.rstudio_security_group.id
  ]
  #count          = length(var.persistence_private_subnets_id)
  #subnet_id      = element(var.persistence_private_subnets_id, count.index)
  subnet_id = var.persistence_private_subnets_id[0]
  #subnet_id = "subnet-0625eb058829ed8d8"
  #availability_zone = "${var.zone}"

  #key_name = "${var.keypair_name}"

  # add a public IP address
  #associate_public_ip_address = true

  #root_block_device  {
  #  volume_type          = "standard"
  #  volume_size           = "40"
  #  delete_on_termination = true
  #}

  tags={
    Name = "Rstudio Server"
  }
}


