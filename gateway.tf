resource "aws_internet_gateway" "IGW" {

    vpc_id = aws_vpc.vpc01.id

    tags = {
      Name = "${random_pet.pet_name.id}-IGW"
    }  
}


resource "aws_nat_gateway" "nat_gw" {
    allocation_id = aws_eip.nat_eip_gw.id
    subnet_id = aws_subnet.private_subnet.id

    tags = {
      Name = "${random_pet.pet_name.id}-NAT-IGW"
    }
  
}
