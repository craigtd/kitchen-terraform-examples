terraform {
  required_version = "~> 0.10.2"
}

provider "aws" {
  region  = "${var.provider_region}"
  version = "~> 0.1"
}

resource "aws_vpc" "example" {
  cidr_block           = "192.168.0.0/16"
  enable_dns_hostnames = "true"

  tags {
    Name = "kitchen_terraform_example"
  }
}

resource "aws_subnet" "example" {
  availability_zone       = "${var.subnet_availability_zone}"
  cidr_block              = "192.168.1.0/24"
  map_public_ip_on_launch = "true"
  vpc_id                  = "${aws_vpc.example.id}"

  tags {
    Name = "kitchen_terraform_example"
  }
}

resource "aws_internet_gateway" "example" {
  vpc_id = "${aws_vpc.example.id}"

  tags {
    Name = "kitchen_terraform_example"
  }
}

resource "aws_route_table" "example" {
  vpc_id = "${aws_vpc.example.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.example.id}"
  }

  tags {
    Name = "kitchen_terraform_example"
  }
}

resource "aws_route_table_association" "example" {
  subnet_id      = "${aws_subnet.example.id}"
  route_table_id = "${aws_route_table.example.id}"
}

resource "aws_security_group" "example" {
  description = "Allow all inbound traffic"
  name        = "kitchen-terraform-example"
  vpc_id      = "${aws_vpc.example.id}"

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }

  tags {
    Name      = "kitchen-terraform-example"
    Terraform = "true"
  }
}

resource "aws_key_pair" "example" {
  key_name   = "kitchen-terraform-example"
  public_key = "${var.key_pair_public_key}"
}

resource "aws_instance" "reachable_other_host" {
  ami                         = "${var.instances_ami}"
  associate_public_ip_address = true
  instance_type               = "t2.micro"
  key_name                    = "${aws_key_pair.example.key_name}"
  vpc_security_group_ids      = ["${aws_security_group.example.id}"]
  subnet_id                   = "${aws_subnet.example.id}"

  tags {
    Name      = "kitchen-terraform-reachable-other-host"
    Terraform = "true"
  }
}

resource "aws_instance" "test_target" {
  ami                    = "${var.instances_ami}"
  count                  = 2
  instance_type          = "t2.micro"
  key_name               = "${aws_key_pair.example.key_name}"
  subnet_id              = "${aws_subnet.example.id}"
  vpc_security_group_ids = ["${aws_security_group.example.id}"]

  tags {
    Name      = "kitchen-terraform-test-target-${count.index}"
    Terraform = "true"
  }
}






