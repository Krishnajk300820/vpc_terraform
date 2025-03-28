resource "aws_subnet" "public_subnet" {
    vpc_id = aws_vpc.vpc01.id
    cidr_block = var.public_subnet_cidr


   tags = {
      Name = "${random_pet.pet_name.id }-public"
   } 
}

resource "aws_subnet" "private_subnet" {
    vpc_id = aws_vpc.vpc01.id
    cidr_block = var.private_subnet_cidr

    tags = {
      Name = "${random_pet.pet_name.id}-private"
    } 
}