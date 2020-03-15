
resource "aws_subnet" "dmz" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.3.0/24"
  map_public_ip_on_launch = true
  depends_on = [aws_internet_gateway.gw]
  tags = {
    Name = "Dmz"
  }
}


locals {
  instance-vpnserver-userdata = <<EOF
apt-get update
apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
apt-key fingerprint 0EBFCD88
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt-get update
apt-get install docker-ce docker-ce-cli containerd.io "> /run/bootstrap.sh 
EOF
}

resource "aws_instance" "vpnserver" {
  ami           = var.ami
  instance_type = "t2.micro"
  private_ip    = "10.0.3.10"
  subnet_id     = aws_subnet.dmz.id 
  key_name      = var.keypair
  vpc_security_group_ids = [aws_security_group.allow_ssh.id, aws_security_group.allow_outbound.id]
  user_data_base64 = base64encode(local.instance-vpnserver-userdata)

  tags = {
    Name = "vpnserver"
  }  
}


resource "aws_eip" "lb" {
  vpc      = true
  instance = aws_instance.vpnserver.id
  associate_with_private_ip = "10.0.3.10"
  depends_on                = [aws_internet_gateway.gw]

  tags = {
    Name = "aws_eip_lb_dmz"
  }
}

data "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id

}

resource "aws_route" "route" {
  route_table_id          = data.aws_route_table.main.id
  destination_cidr_block  = "0.0.0.0/0"
  gateway_id              = aws_internet_gateway.gw.id
}
