
resource "aws_subnet" "infra" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "Infra"
  }
}

resource "aws_instance" "jenkins" {
  ami           = var.jenkins_ami
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.infra.id 
  key_name      = var.keypair
  tags = {
    Name = "jenkins"
  }
}

