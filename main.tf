
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region  = "ap-south-1"
  profile = "mayank"
}

variable "ingress_ports" {
  type = list(number)
  description = "List of Ingress Port"
  default = [22,8080,80]
}

resource "aws_security_group" "sg" {
  name = "Allow Traffic"
  description = "Allow TLS inbound traffic"

  dynamic "ingress" {
    for_each = var.ingress_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "k8master" {
  tags = {
    Name = "K8-master"
  }
  ami           = "ami-0cca134ec43cf708f"
  instance_type = "t2.medium"
  key_name      = "mayank-macos"
  vpc_security_group_ids = ["${aws_security_group.sg.id}"]
  # user_data = "${file("k8master.sh")}"
}

resource "aws_instance" "k8worker" {

  count = 2
  tags = {
    Name = "K8-worker-${count.index}"
  }
  ami           = "ami-0cca134ec43cf708f"
  instance_type = "t2.medium"
  key_name      = "mayank-macos"
  vpc_security_group_ids = ["${aws_security_group.sg.id}"]
  # user_data = "${file("k8worker.sh")}"

}







output "EC2_Master_IP" {
  value = ["${aws_instance.k8master.public_ip}"]
}
