data "aws_ami" "centos" {
  most_recent = true
  owners      = [125523088429]

  filter {
    name   = "name"
    values = ["CentOS 7.9.2009 x86_64"]
  }

}

resource "aws_key_pair" "user_auth" {
  key_name   = var.key_name
  public_key = file(var.pubkey_path)
}

resource "aws_instance" "servers" {
  for_each               = var.instances
  instance_type          = var.instance_type
  ami                    = data.aws_ami.centos.id
  key_name               = aws_key_pair.user_auth.id
  vpc_security_group_ids = [var.public_sg]
  subnet_id              = each.value.subnet_id
  tags = {
    Name = each.value.name
  }
}
