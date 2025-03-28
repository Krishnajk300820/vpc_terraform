resource "aws_instance" "my_windows_server" {
    ami     =  data.aws_ami.windows.id
    instance_type = "t3.large"
    key_name = aws_key_pair.ec2_key.key_name
    subnet_id = aws_subnet.public_subnet.id
    vpc_security_group_ids = [aws_security_group.windows_sg.id]
    get_password_data = true 


    user_data = <<-EOF
              <powershell>
              # Install Chocolatey
              Set-ExecutionPolicy Bypass -Scope Process -Force;
              [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12;
              iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'));

              # Install Git Bash via Chocolatey
              choco install git -y
              
              choco install nodejs -y
              </powershell>
            EOF

    tags = {
      Name = "${random_pet.pet_name.id}-windows_server"
    }
}

resource "aws_instance" "my_linux_server" {
    ami     =  "ami-0efc43a4067fe9a3e"
    instance_type = "t3.large"
    key_name = aws_key_pair.ec2_key.key_name
    subnet_id = aws_subnet.private_subnet.id
    vpc_security_group_ids = [aws_security_group.linux_sg.id]

    tags = {
      Name = "${random_pet.pet_name.id}-linux_server"
    }
}