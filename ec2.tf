# resource "aws_instance" "demo" {
#   ami           = "ami-073998ba87e205747"
#   instance_type = "t2.micro"

#   network_interface {
#     network_interface_id = aws_network_interface.demo-ENI.id
#     device_index         = 0
#   }
#   key_name = aws_key_pair.deployer.id
#   tags = {
#     Name = "HelloWorld"
#   }
# }

# resource "aws_key_pair" "deployer" {
#   key_name   = "id_ed25519.pub"
#   public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHAzSVTR1P7Iu9OjsfGAId52pefxUku6t9vPNhv1i9P0 ws0599@administrator-OptiPlex-3080"
# }

# resource "aws_security_group" "allow_tls" {
#   name        = "allow_tls"
#   description = "Allow TLS inbound traffic"
#   vpc_id      = aws_vpc.main.id

#   tags = {
#     Name = "allow_tls"
#   }
# }

# resource "aws_security_group_rule" "example" {
#   type              = "ingress"
#   from_port         = 22
#   to_port           = 22
#   protocol          = "tcp"
#   cidr_blocks       = ["13.213.52.236/32"]
#   security_group_id = aws_security_group.allow_tls.id
# }

# resource "aws_network_interface" "demo-ENI" {
#   subnet_id       = aws_subnet.subnet1.id
#   private_ips     = ["172.16.0.10"]
#   security_groups = [aws_security_group.allow_tls.id]
#   tags = {
#     Name = "demo-ENI"
#   }
# }


resource "aws_instance" "web" {

  ami           = "ami-0d058fe428540cd89"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public_a.id

  key_name               = aws_key_pair.dev.key_name
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]

  tags = {
    Name = "web-01"
  }
}

resource "aws_instance" "backend" {

  ami           = "ami-0d058fe428540cd89"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public_a.id

  key_name               = aws_key_pair.dev.key_name
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]

  tags = {
    Name = "backend-01"
  }
}

# tạo ssh keypair

resource "aws_key_pair" "dev" {
  key_name   = "dev-key"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHAzSVTR1P7Iu9OjsfGAId52pefxUku6t9vPNhv1i9P0 ws0599@administrator-OptiPlex-3080"
}

# tạo security group allow ssh

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "SSH from specify IPs"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["13.213.52.236/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# in ra public ip của ec2 instance
output "ec2_instance_public_ips" {
  value = aws_instance.web.*.public_ip
}
