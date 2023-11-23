#!/bin/bash
              apt-get update
              sudo apt-get install -y software-properties-common
              sudo  apt-add-repository -y ppa:ansible/ansible
              sudo apt-get update
              sudo apt-get install -y ansible
              echo 'export PATH=$PATH:/usr/bin/ansible' >> /etc/bash.bashrc
              
              # Adicionar localhost ao known_hosts
              ssh-keyscan -H localhost >> ~/.ssh/known_hosts
              

              # Executar o playbook Ansible com conexão local
              sudo ansible-playbook -c local -i localhost, /home/ubuntu/ansible/playbook.yml