
resource "aws_subnet" "infra" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "Infra"
  }
}

# TODO: split to docker installation and docker run as a service
locals {
  instance-jenkins-userdata = <<EOF
#!/bin/bash
export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get -y install apt-transport-https ca-certificates curl gnupg-agent software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
apt-key fingerprint 0EBFCD88
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io

OVPN_DATA="ovpn-data-example"
docker volume create --name $OVPN_DATA
docker run -v $OVPN_DATA:/etc/openvpn --log-driver=none --rm kylemanna/openvpn ovpn_genconfig -u udp://VPN.SERVERNAME.COM
docker run -v $OVPN_DATA:/etc/openvpn --log-driver=none --rm -it kylemanna/openvpn ovpn_initpki
docker run -v $OVPN_DATA:/etc/openvpn -d -p 1194:1194/udp --cap-add=NET_ADMIN kylemanna/openvpn


EOF
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

