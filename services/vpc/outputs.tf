output "vpc_id" {
    value       = "${aws_vpc.vpc.id}"
    description = "vpc-id"
}

output "public_subnet_id_1" {
    value       = "${aws_subnet.publicSubnet1.id}"
    description = "public_subnet_id_01"
}

output "public_subnet_id_2" {
    value       = "${aws_subnet.publicSubnet2.id}"
    description = "public_subnet_id_02"
}

output "private_subnet_id_1" {
    value       = "${aws_subnet.privateSubnet1.id}"
    description = "private_subnet_id_01"
}

output "private_subnet_id_2" {
    value       = "${aws_subnet.privateSubnet2.id}"
    description = "private_subnet_id_02"
}

output "public_web_sg" {
    value       = "${aws_security_group.publicSG01.id}"
    description = "public_sg01"
}

output "private_mysql_sg" {
    value       = "${aws_security_group.privateSG01.id}"
    description = "private_sg01"
}

