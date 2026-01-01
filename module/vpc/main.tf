resource "aws_vpc" "webserver" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "my_vpc"
  }
}

# Get list of availability zones
data "aws_availability_zones" "available" {
  state = "available"
}


# Private Subnet
resource "aws_subnet" "private_subnet" {
  count = 2
  vpc_id            = aws_vpc.webserver.id
  cidr_block        = var.private_subnets[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = false  # Private subnets should not map public IPs
  tags = {
    Name = "private_subnet"
  }
}
# Public Subnet
resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.webserver.id
  count = 2
  cidr_block        = var.public_subnets[count.index]
  map_public_ip_on_launch = true
  availability_zone = data.aws_availability_zones.available.names[count.index]
  tags = {
    Name = "public_subnet"
  }
}
# Internet Gateway and NAT Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.webserver.id
  tags = {
    Name = "my_igw"
  }
}

resource "aws_eip" "nat_gw" {
  domain = "vpc"
  tags = {
    Name = "my_nat_gw"
  }
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_gw.id
  subnet_id     = aws_subnet.public_subnet[0].id
}

# Public Route Table (for public subnet)
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.webserver.id
}

 # associate all public subnets to the public route table
resource "aws_route_table_association" "public_association" {
  count =  length(aws_subnet.public_subnet)
  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.public_rt.id
  
}

# create route for the public route table and attach the internet gateway
resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

# Private Route Table (for private subnet)
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.webserver.id
}

# create route for the private route table and attach the NAT gateway
resource "aws_route" "private_route" {
  route_table_id         = aws_route_table.private_rt.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gateway.id
}
# associate all private subnets to the private route table
resource "aws_route_table_association" "private_association" {
  count = length(aws_subnet.private_subnet)
  subnet_id      = aws_subnet.private_subnet[count.index].id
  route_table_id = aws_route_table.private_rt.id
}