resource "aws_vpc" "main" {
    cidr_block ="10.0.0.0/24"
    tags = {
        Name = "my-vpc"
    }
}
resource "aws_subnet" "main" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.0.0/26"
}
resource "aws_subnet" "main2" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.0.64/26"
}
resource "aws_security_group" "main" {
    vpc_id = aws_vpc.main.id
    name = "my-security-group"
    description = "Security group for my instance"
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress  {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress  {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
}
}

resource "aws_internet_gateway" "main" {
    vpc_id = aws_vpc.main.id
    tags = {
        Name = "my-igw"
    }
}
resource "aws_route_table" "main" {
    vpc_id = aws_vpc.main.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.main.id
    }
}   
resource "aws_route_table_association" "main" {
    subnet_id = aws_subnet.main.id
    route_table_id = aws_route_table.main.id
}
resource "aws_eip" "main" {
    domain = "vpc"
    tags = {
        Name = "my-eip"
    }
}

resource "aws_nat_gateway" "main" {
    allocation_id = aws_eip.main.id
    subnet_id = aws_subnet.main2.id
    tags = {
        Name = "my-nat-gateway"
    }
}
resource "aws_route_table" "private_rt" {
    vpc_id = aws_vpc.main.id
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.main.id
    }
}
resource "aws_route_table_association" "private_rt_assoc" {
    subnet_id = aws_subnet.main2.id
    route_table_id = aws_route_table.private_rt.id
}
resource "aws_instance" "main" {
    ami = var.ami_id
    instance_type = var.instance_type
    subnet_id = aws_subnet.main.id
    tags = {
        Name = "my-instance"
    }
  
}