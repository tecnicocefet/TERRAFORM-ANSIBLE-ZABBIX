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

  user_data = <<-EOF
              #!/bin/bash
              apt-get update
              sudo apt-get install software-properties-common
              sudo  apt-add-repository -y ppa:ansible/ansible
              sudo apt-get update
              sudo apt-get install -y ansible
              echo 'export PATH=$PATH:/usr/bin/ansible' >> /etc/bash.bashrc
              # Adicionar localhost ao known_hosts
              ssh-keyscan -H localhost >> ~/.ssh/known_hosts
              chmod +x /home/ubuntu/ansible/playbook.yml

              # Executar o playbook Ansible com conexão local
          

              
              EOF


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


