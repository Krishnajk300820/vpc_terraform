resource "aws_vpc" "vpc01" {
    cidr_block = var.vpc_cidr
    
    tags = {

        Name = "${random_pet.pet_name.id}-my-vpc"
    } 
}


output "public_ip" {
    value = aws_eip.windows_eip.public_ip  
}
output "private_ip" {
    value = aws_instance.my_windows_server.private_ip  
}

output "random_pet" {
    value = random_pet.pet_name  
}

output "ami_id" {
  value = data.aws_ami.windows.id
}

output "windows_rdp_pwd" {
    value = rsadecrypt(aws_instance.my_windows_server.password_data, file("${random_pet.pet_name.id}-private-key"))
    sensitive = false
}

output "linux_ssh" {
  value = "ssh -i \"${random_pet.pet_name.id}-ec2_key.pem\" ec2-user@${aws_instance.my_linux_server.private_ip}"
  description = "The ssh command for the Linux server"
}

