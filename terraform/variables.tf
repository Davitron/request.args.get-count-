variable "aws_credentials" {
  type   = string
  default  = "~/.aws/credentials"
}

variable "region" {
  type = string
  default = "us-east-2"
}

variable "az" {
  type = string
  default = "us-east-2a"
}


variable "subnet_cidr" {
  type = string
  default = "192.168.0.0/17"
}


variable "vpc_cidr" {
  type = string
  default = "192.168.0.0/16"
}

variable "public_key_path" {
  type    = string
  default = "~/.ssh/sample.pub"
}

variable "private_key_path" {
  type    = string
  default = "~/.ssh/sample"
}

variable "instance_type" {
  type    = string
  default = "t2.medium"
}

variable "ansible_role_file" {
  type    = string
  default = "../ansible/roles/ec2/tasks/main.yml"
}

variable "ansible_playbook_file" {
  type    = string
  default = "../ansible/playbook.yml"
}
