provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "terraform" {
  ami           = "ami-0fc5d935ebf8bc3bc"
  instance_type = "t3.medium"


  key_name = "labs" # Alterado para o nome da chave importada

  tags = {
    Name = "exemplo-terraform"
  }

  # Carrega o conteúdo do script user_data.sh
  user_data = file("${path.module}/user_data.sh")


  provisioner "file" {
    source      = "/home/jco/PROJETOS/DEVOPS/terraform+ansible+aws/ansible"
    destination = "/home/ubuntu"

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file(var.private_key_path)
      host        = self.public_ip
      agent       = false
      timeout     = "2m"

    }
  }

}


