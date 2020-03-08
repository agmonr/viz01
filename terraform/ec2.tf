
resource "aws_instance" "jenkins" {
  ami           = var.jenkins_ami
  instance_type = "t2.micro"
  subnet_id    = aws_subnet.infra.id 
  key_name      = var.keypair
  tags = {
    name = "jenkins"
  }
}

