
resource "aws_subnet" "dmz" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.3.0/24"
  map_public_ip_on_launch = true
  depends_on = [aws_internet_gateway.gw]
  tags = {
    Name = "Dmz"
  }
}

resource "aws_instance" "vpnserver" {
  ami           = var.ami
  instance_type = "t2.micro"
  private_ip    = "10.0.3.10"
  subnet_id     = aws_subnet.dmz.id 
  key_name      = var.keypair
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
  
  
  tags = {
    Name = "vpnserver"
  }  
}

resource "aws_eip" "lb" {
  vpc      = true
  instance = aws_instance.vpnserver.id
  associate_with_private_ip = "10.0.3.10"
  depends_on                = [aws_internet_gateway.gw]
}

data "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id 
}

resource "aws_route" "route" {
  route_table_id          = data.aws_route_table.main.id
  destination_cidr_block  = "0.0.0.0/0"
  gateway_id              = aws_internet_gateway.gw.id
}
