/* Private subnet */
resource "aws_subnet" "private" {
  vpc_id            = "${aws_vpc.ecs.id}"
  cidr_block        = "${var.private_subnet_cidr}"
  availability_zone = "eu-west-1a"
  map_public_ip_on_launch = false
  depends_on = ["aws_instance.nat"]
  tags { 
    Name = "private" 
  }
}

/* Routing table for private subnet */
resource "aws_route_table" "private" {
  vpc_id = "${aws_vpc.ecs.id}"
  route {
    cidr_block = "0.0.0.0/0"
    instance_id = "${aws_instance.nat.id}"
  }
}
