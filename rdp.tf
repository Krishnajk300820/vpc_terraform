resource "local_file" "rdp_file" {
    content = templatefile("./rdp.tpl", {
        public_ip = aws_eip.windows_eip.public_ip
    })
    filename = "./${random_pet.pet_name.id}-windows.rdp"
}

resource "local_file" "rdp_file_1" {
    filename = "${random_pet.pet_name.id}-windows1.rdp"
    content = <<-RDP_CONTENT
    auto connect:i:1
    full address:s:${aws_eip.windows_eip.public_ip}
    username:s:Administrator
    audiomode:i:2
    audiocapturemode:i:1
    RDP_CONTENT

    depends_on = [ aws_instance.my_windows_server, aws_eip.windows_eip ]

}

resource "null_resource" "rdp_exec" {
    provisioner "local-exec" {
        command = "open ./${random_pet.pet_name.id}-windows1.rdp"
      
    }

    triggers = {
        windows_dns = aws_instance.my_windows_server.public_dns
        always_run = timestamp()
        }

    depends_on = [ local_file.rdp_file_1 ]
  
}

