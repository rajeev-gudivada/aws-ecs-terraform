output "vpc_id" {
  value = "${aws_vpc.vpc.id}"
}

output "public_subnets_id" {
  value = "${aws_subnet.public_subnet.*.id}"
}

output "app_private_subnets_id" {
  value = "${aws_subnet.app_private_subnet.*.id}"
}

output "persistence_private_subnets_id" {
  value = "${aws_subnet.persistence_private_subnet.*.id}"
}

output "default_sg_id" {
  value = "${aws_security_group.default.id}"
}

output "security_groups_ids" {
  value = ["${aws_security_group.default.id}"]
}

output "public_route_table" {
  value = "${aws_route_table.public.id}"
}
