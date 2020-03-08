

data "aws_vpc" "main" {
  id = aws_vpc.main.id
}

data "aws_subnet_ids" "infra" {
  vpc_id = data.aws_vpc.main.id

  tags = {
    Name = "Infra"
  }
}

resource "aws_instance" "Jenkins" {
//  for_each      = data.aws_subnet_ids.infra.ids
  ami           = var.jenkins_ami
  instance_type = "t2.micro"
  subnet_id    = element(data.aws_subnet_ids.infra.vpc_id[*], 1)
  key_name      = var.keypair
  tags = {
    Name = "jenkins"
  }
}
