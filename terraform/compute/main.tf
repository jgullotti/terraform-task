
data "aws_ami" "centos" {
  most_recent = true
  owners      = [125523088429]

  filter {
    name   = "name"
    values = ["CentOS 7.9.2009 x86_64"]
  }

}

# TODO refactor instances, dry it up...
resource "aws_instance" "server1" {
  instance_type = var.instance_type
  ami           = data.aws_ami.centos.id
  tags = {
    Name = "Server1"
  }
  vpc_security_group_ids = [var.public_sg]
  subnet_id              = var.subnets[0].id
}

resource "aws_instance" "server2" {
  instance_type = var.instance_type
  ami           = data.aws_ami.centos.id
  tags = {
    Name = "Server2"
  }
  vpc_security_group_ids = [var.public_sg]
  subnet_id              = var.subnets[1].id
}
