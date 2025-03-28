resource "aws_security_group" "windows_sg" {
    name = "windows SG"
    description = "Allow inbpund traffic for HTTP, HTTPS, RDP"
    vpc_id = aws_vpc.vpc01.id
    
    ingress{
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = [var.all_ip]
    }

    ingress{
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = [var.all_ip]
    }

    ingress{
        from_port = 3389
        to_port = 3389
        protocol = "tcp"
        cidr_blocks = [var.all_ip]
    }

    egress{
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = [var.all_ip]
    }

    tags = {
      name = "${random_pet.pet_name.id}-windows_sg"
    }  
}

resource "aws_security_group" "linux_sg" {
    name = "Linux SG"
    description = "Allow inbound traffic for SSH, MYSql"
    vpc_id = aws_vpc.vpc01.id

    ingress{
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = [var.vpc_cidr]
    }

    ingress{
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        cidr_blocks = [var.vpc_cidr]
    }

    egress{
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = [var.all_ip]
    }

    tags = {
      Name = "${random_pet.pet_name.id}-linux_sg"
    }  
}







#NACL

resource "aws_default_network_acl" "main_nacl" {
    default_network_acl_id = aws_vpc.vpc01.default_network_acl_id

ingress {
    rule_no    = 100
    protocol   = "tcp"
    action     = "allow"
    cidr_block = var.all_ip
    from_port  = 80
    to_port    = 80
}
ingress {
    rule_no    = 200
    protocol   = "tcp"
    action     = "allow"
    cidr_block = var.all_ip
    from_port  = 443
    to_port    = 443
}

ingress {
    rule_no    = 300
    protocol   = "tcp"
    action     = "allow"
    cidr_block = var.all_ip
    from_port  = 22
    to_port    = 22
}

ingress {
    rule_no    = 400
    protocol   = "tcp"
    action     = "allow"
    cidr_block = var.all_ip
    from_port  = 1024
    to_port    = 65535
}


egress {
    rule_no    = 100
    protocol   = "-1"
    action     = "allow"
    cidr_block = var.all_ip
    from_port  = 0
    to_port    = 0
}

    tags = {
        Name = "${random_pet.pet_name.id}-nacl"
    }
  
}

