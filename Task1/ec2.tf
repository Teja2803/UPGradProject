resource "aws_instance" "public_ec2" {
  ami           = "ami-0e35ddab05955cf57" # Amazon Linux 2 (us-east-1)
  instance_type = "t2.medium"
  subnet_id     = aws_subnet.public["0"].id
  vpc_security_group_ids = [aws_security_group.sg_ssh_all.id]
  key_name = "key"

  tags = {
    Name = "${var.env}-ec2-public"
  }
}

resource "aws_instance" "private_ec2_1" {
  ami           = "ami-0e35ddab05955cf57"
  instance_type = "t2.medium"
  subnet_id     = aws_subnet.private["0"].id
  vpc_security_group_ids = [aws_security_group.sg_vpc_only.id]
  key_name = "key"

  tags = {
    Name = "${var.env}-ec2-private-1"
  }
}

resource "aws_instance" "private_ec2_2" {
  ami           = "ami-0e35ddab05955cf57"
  instance_type = "t2.medium"
  subnet_id     = aws_subnet.private["1"].id
  vpc_security_group_ids = [aws_security_group.sg_vpc_only.id]
  key_name = "key"

  tags = {
    Name = "${var.env}-ec2-private-2"
  }
}
