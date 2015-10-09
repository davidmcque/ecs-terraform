resource "aws_instance" "nat" {
	ami = "${lookup(var.nat_ami, var.region)}"
	availability_zone = "eu-west-1a"
	instance_type = "t2.micro"
	key_name = "${aws_key_pair.ecs.key_name}"
	security_groups = ["${aws_security_group.ecs.id}", "${aws_security_group.nat.id}"]
	subnet_id = "${aws_subnet.public.id}"
	associate_public_ip_address = true
	source_dest_check = false
        tags = { 
               Name = "nat"
               }
}
