resource "aws_instance" "web" {
  ami           = "ami-0fc5d935ebf8bc3bc" # Ubuntu 22
  instance_type = var.instance_type
  key_name      = "ec2-key"
  security_groups = [aws_security_group.web.name]

  tags = {
    Name        = var.instance_name
  }
}

resource "aws_instance" "ansible_control" {
  ami           = "ami-0fc5d935ebf8bc3bc" # Ubuntu 22
  instance_type = var.instance_type
  key_name      = "ec2-key"
  security_groups = [aws_security_group.ansible.name]
  tags = {
    Name        = var.instance_name
  }

  user_data = <<-EOF
              #!/bin/bash
              apt-get update -y
              apt-get install -y ansible
              EOF


  provisioner "local-exec" {
    command = "sleep 30 && scp -i ${local_file.TF-key.filename} -o StrictHostKeyChecking=no tf.key ubuntu@${self.public_ip}:/home/ubuntu/tf.key"
}
  provisioner "local-exec" {
    command = "scp -i ${local_file.TF-key.filename} -o StrictHostKeyChecking=no hosts.ini ubuntu@${self.public_ip}:/home/ubuntu/hosts.ini"
}
  provisioner "local-exec" {
    command = "scp -i ${local_file.TF-key.filename} -o StrictHostKeyChecking=no ../ansible/playbooks/main.yml ubuntu@${self.public_ip}:/home/ubuntu/main.yml"
}
  provisioner "local-exec" {
    command = "scp -r -i ${local_file.TF-key.filename} -o StrictHostKeyChecking=no ../application-code/ ubuntu@${self.public_ip}:/home/ubuntu/"
}

  provisioner "remote-exec" {
    inline = [
    "ssh-keyscan $(cat /home/ubuntu/hosts.ini) >> ~/.ssh/known_hosts",
    "chmod 600 /home/ubuntu/tf.key",
    "chmod +x /home/ubuntu/application-code/nginx.sh",
    "bash /home/ubuntu/application-code/nginx.sh",
    "ansible-playbook --private-key=/home/ubuntu/tf.key /home/ubuntu/main.yml -i /home/ubuntu/hosts.ini"
    ]

 connection {
    type        = "ssh"
    host        = aws_instance.ansible_control.public_ip
    user        = "ubuntu"
    private_key = tls_private_key.rsa-4096.private_key_pem
  }	
  }
}
resource "aws_key_pair" "ec2-key" {
  key_name   = "ec2-key"
  public_key = tls_private_key.rsa-4096.public_key_openssh
}

resource "tls_private_key" "rsa-4096" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_security_group" "web" {
  name = "web"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 5500
    to_port     = 5500
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "ansible" {
  name = "ansible"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "local_file" "TF-key" {
  content  = tls_private_key.rsa-4096.private_key_pem
  filename = "tf.key"
}

resource "local_file" "ec2_public_ip_file" {
  filename = "hosts.ini"
  content  = join("\n", [aws_instance.web.public_ip])
}

output "instance_public_ip" {
  value = aws_instance.web.public_ip
}