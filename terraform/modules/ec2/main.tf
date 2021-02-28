resource "aws_key_pair" "key_pair" {
  key_name = "sample_pem"
  public_key = file(var.public_key_path)
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

resource "aws_instance" "server" {
  ami      =  data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  key_name = aws_key_pair.key_pair.key_name
  subnet_id = var.subnet_id
  vpc_security_group_ids = [ var.security_group_id ]
  associate_public_ip_address = true
  
  tags = {
    "Name" = "Instance-Jenkins"
  }
}

data "template_file" "ansible_role_file" {
  template    = file(var.ansible_role_file)
}

data "template_file" "ansible_playbook_file" {
  template    = file(var.ansible_playbook_file)
}




resource "null_resource" "provision" {
  triggers = {
    ansible_role_file     = md5(data.template_file.ansible_role_file.rendered)
    ansible_playbook_file = md5(data.template_file.ansible_playbook_file.rendered)
  }

  depends_on = [ aws_instance.server ]

  provisioner "remote-exec" {
      inline = ["echo hello!"]
      connection {
        host     = aws_instance.server.public_ip
        type     = "ssh"
        user     = "ubuntu"
        private_key = file(var.private_key_path)
      }
  }


  provisioner "local-exec" {
    command = <<EOT
      ls
      ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i '${aws_instance.server.public_ip},' --private-key ${var.private_key_path} -u ubuntu ../ansible/playbook.yml
    EOT
  }
}