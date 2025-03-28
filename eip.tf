resource "aws_eip" "windows_eip" {

    tags = {
      Name = random_pet.pet_name.id
    } 
}



resource "aws_eip_association" "windows_eip_assoc" {
    instance_id = aws_instance.my_windows_server.id
    allocation_id = aws_eip.windows_eip.id  
}


resource "aws_eip" "nat_eip_gw" {
    tags = {
        Name = "${random_pet.pet_name.id}-NAT-eip-IGW"
    }
  
}

