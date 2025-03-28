resource "aws_default_route_table" "main_rt" {
    default_route_table_id = aws_vpc.vpc01.default_route_table_id

    route {
        cidr_block = var.all_ip
        gateway_id = aws_nat_gateway.nat_gw.id
    }

    tags = {
      Name = "${random_pet.pet_name.id}-main-rt"
    }  
}

resource "aws_route_table" "public_rt" {

    vpc_id = aws_vpc.vpc01.id
    route  {
        cidr_block = var.all_ip
        gateway_id = aws_internet_gateway.IGW.id
    }

    tags = {
      Name = "${random_pet.pet_name.id}-default-public_rt"
    } 
}

resource "aws_route_table_association" "public_rta" {
    subnet_id = aws_subnet.public_subnet.id
    route_table_id = aws_route_table.public_rt.id  
}
