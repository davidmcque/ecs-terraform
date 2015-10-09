resource "aws_key_pair" "ecs" {
  key_name = "ecs-key"
  public_key = "${file(\"ssh/ecs.pub\")}"
}
