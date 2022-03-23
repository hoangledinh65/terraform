# resource "aws_vpc" "main" {
#   cidr_block = "172.16.0.0/16"
#   tags = {
#     Name = "bluemarble-VPC-2"
#   }
# }

# resource "aws_internet_gateway" "gw" {
#   vpc_id = aws_vpc.main.id

#   tags = {
#     Name = "main"
#   }
# }


# #Subnets
# resource "aws_subnet" "subnet1" {
#   vpc_id     = aws_vpc.main.id
#   cidr_block = "172.16.0.0/24"

#   tags = {
#     Name = "VPC2-Public-Subnet"
#   }
#   availability_zone = "ap-southeast-1a"
# }

# resource "aws_subnet" "subnet2" {
#   vpc_id     = aws_vpc.main.id
#   cidr_block = "172.16.2.0/24"

#   tags = {
#     Name = "VPC2-Private-Subnet"
#   }
#   availability_zone = "ap-southeast-1b"
# }


# #Route Tables
# resource "aws_route_table" "VPC2-Public-RouteTable" {
#   vpc_id = aws_vpc.main.id

#   tags = {
#     Name = "VPC2-RouteTable"
#   }
# }

# resource "aws_route" "r" {
#   route_table_id         = aws_route_table.VPC2-Public-RouteTable.id
#   destination_cidr_block = "0.0.0.0/0"
#   gateway_id             = aws_internet_gateway.gw.id

# }

# resource "aws_route_table_association" "a" {
#   subnet_id      = aws_subnet.subnet1.id
#   route_table_id = aws_route_table.VPC2-Public-RouteTable.id
# }



# tạo vpc network
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc
resource "aws_vpc" "main" {
  cidr_block = "10.9.0.0/16"

  tags = {
    Name = "devpos-techmaster-03-vpc"
  }
}

# tạo public subnet
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet
resource "aws_subnet" "public_a" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.9.1.0/24"
  availability_zone       = "ap-southeast-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-a"
  }
}

# tạo internet gateway cho public subnet

resource "aws_internet_gateway" "ig" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "devops-techmaster-03-igw"
  }
}

# tạo public routing table cho public subnet

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "public-route-table"
  }
}

# tạo default route cho public routing table

resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.ig.id
}

# gán public subnet vào public routing table

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_route_table.public.id
}