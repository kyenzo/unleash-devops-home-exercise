# Create VPC
resource "aws_vpc" "evgeni_vpc" {
  cidr_block = "10.3.0.0/16"
}

# Create Subnet
resource "aws_subnet" "evgeni_subnet" {
  vpc_id            = aws_vpc.evgeni_vpc.id
  cidr_block        = "10.3.1.0/24"
  availability_zone = "us-east-1a"
}

# Create Internet Gateway
resource "aws_internet_gateway" "evgeni_igw" {
  vpc_id = aws_vpc.evgeni_vpc.id
}

# Create Route Table
resource "aws_route_table" "evgeni_route_table" {
  vpc_id = aws_vpc.evgeni_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.evgeni_igw.id
  }
}

# Associate Route Table with Subnet
resource "aws_route_table_association" "evgeni_rta" {
  subnet_id      = aws_subnet.evgeni_subnet.id
  route_table_id = aws_route_table.evgeni_route_table.id
}