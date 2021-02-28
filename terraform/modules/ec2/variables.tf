variable "public_key_path" {
  type   = string
}

variable "private_key_path" {
  type   = string
}


variable "instance_type" {
  type   = string
}

variable "subnet_id" {
  type   = string
}

variable "security_group_id" {
  type   = string
}

variable "ansible_role_file" {
  type = string
}

variable "ansible_playbook_file" {
  type = string
}