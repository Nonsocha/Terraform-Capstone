##Create a VPC with the specified CIDR block and enable DNS support and hostnames. Tag the VPC with the name "Wordpress-vpc".
## create vpc
resource "aws_vpc" "main" {
    cidr_block = var.vpc_cidr
    enable_dns_hostnames = true
    enable_dns_support = true
    tags = {
        Name = "Wordpress-vpc"
    }
  
}

##INTERNET GATEWAY
resource "aws_internet_gateway" "gw" {
    vpc_id = aws_vpc.main.id
    tags = {
        Name = "Wordpress-igw"
    }
  
}


##PRIVATE SUBNET
resource "aws_subnet" "private" {
  count             = length(var.private_subnet_cidrs)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]

    tags = {
        Name = "Wordpress-private-subnet"
    }
}


##PUBLIC SUBNET
resource "aws_subnet" "public" {
  count             = length(var.public_subnet_cidrs)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.public_subnet_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]

    tags = {
        Name = "Wordpress-public-subnet"
    }
}

## NAT GATEWAY
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[0].id
  depends_on = [ aws_internet_gateway.gw ]

    }
## ELASTIC IP FOR NAT GATEWAY
resource "aws_eip" "nat" {
  domain = "vpc"
}

##ROUTE TABLE FOR PUBLIC SUBNET
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.gw.id
    }
    tags = {
        Name = "Wordpress-public-rt"
    }
}


##ROUTE TABLE ASSOCIATION FOR PUBLIC SUBNET
resource "aws_route_table_association" "public" {
   count = length(aws_subnet.public) 
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public_rt.id
}

## ROUTE TABLE FOR PRIVATE SUBNET
resource "aws_route_table" "private_rt" {
    vpc_id = aws_vpc.main.id
        route {
            cidr_block = "0.0.0.0/0"
            nat_gateway_id = aws_nat_gateway.nat.id
        }
}

## ROUTE TABLE ASSOCIATION FOR PRIVATE SUBNET
resource "aws_route_table_association" "private_association" {
    count = length(aws_subnet.private)
    subnet_id = aws_subnet.private[count.index].id
    route_table_id = aws_route_table.private_rt.id
}



