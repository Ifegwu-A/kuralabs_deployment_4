variable "aws_access_key" {}
variable "aws_secret_key" {}

provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region = "us-east-1"
  
}

# INSTANCES

resource "aws_instance" "web_server01" {
  ami                    = "ami-08c40ec9ead489470"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.subnet1.id
  vpc_security_group_ids = [aws_security_group.web_ssh.id]
  key_name               = "awskey"
  
  user_data = "${file("deploy.sh")}"
  
  tags = {
    "Name" : "web_server01"
  }  
}

# VPC
resource "aws_vpc" "test-vpc" {
  cidr_block           = "192.168.0.0/16"
  enable_dns_hostnames = "true"
 
  tags = {
    "Name" : "test-vpc"
  }
}

# ELASTIC IP
resource "aws_eip" "nat_eip_prob" {
  vpc = true
 
}

# NAT GATEWAY
resource "aws_nat_gateway" "nat_gateway_prob" {
  allocation_id = aws_eip.nat_eip_prob.id
  subnet_id     = aws_subnet.subnet1.id
}


# SUBNET 1
resource "aws_subnet" "subnet1" {
  cidr_block              = "192.168.0.0/18"
  vpc_id                  = aws_vpc.test-vpc.id
  map_public_ip_on_launch = "true"
  availability_zone       = data.aws_availability_zones.available.names[0]
}
 
# SUBNET 2
resource "aws_subnet" "pri_subnet1" {
  cidr_block              = "192.168.64.0/18"
  vpc_id                  = aws_vpc.test-vpc.id
  map_public_ip_on_launch = "false"
  availability_zone       = data.aws_availability_zones.available.names[0]
}
 
# INTERNET GATEWAY
resource "aws_internet_gateway" "gw_1" {
  vpc_id = aws_vpc.test-vpc.id
}
 
# ROUTE TABLE
resource "aws_route_table" "route_table1" {
  vpc_id = aws_vpc.test-vpc.id
 
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw_1.id
  }
}
 
resource "aws_route_table_association" "route-subnet1" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.route_table1.id
}
 
# PRIVATE ROUTE TABLE
resource "aws_route_table" "route_table2" {
  vpc_id = aws_vpc.test-vpc.id
 
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway_prob.id
  }
}
 
resource "aws_route_table_association" "route-subnet2" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.route_table1.id
}
 
 
# DATA
data "aws_availability_zones" "available" {
  state = "available"
}
