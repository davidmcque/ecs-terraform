/* Internet gateway for the public subnet */
resource "aws_internet_gateway" "ecs" {
  vpc_id = "${aws_vpc.ecs.id}"
}

/* Public subnet */
resource "aws_subnet" "public" {
  vpc_id            = "${aws_vpc.ecs.id}"
  cidr_block        = "${var.public_subnet_cidr}"
  availability_zone = "eu-west-1a"
  map_public_ip_on_launch = true
  depends_on = ["aws_internet_gateway.ecs"]
  tags { 
    Name = "public" 
  }
}

/* Routing table for public subnet */
resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.ecs.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.ecs.id}"
  }
}

/* Associate the routing table to public subnet */
resource "aws_route_table_association" "public" {
  subnet_id = "${aws_subnet.public.id}"
  route_table_id = "${aws_route_table.public.id}"
}