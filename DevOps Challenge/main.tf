provider "aws" {
  region = var.region
}

resource "aws_vpc" "example" {
  cidr_block = "17.1.0.0/25"
  tags = {
    Name = "YourName-VPC"
  }
}

resource "aws_subnet" "subnet1" {
  vpc_id            = aws_vpc.example.id
  cidr_block        = cidrsubnet(aws_vpc.example.cidr_block, 4, 0)
  availability_zone = element(var.availability_zones, 0)
  tags = {
    Name = "subnet1"
  }
}

resource "aws_subnet" "subnet2" {
  vpc_id            = aws_vpc.example.id
  cidr_block        = cidrsubnet(aws_vpc.example.cidr_block, 4, 1)
  availability_zone = element(var.availability_zones, 1)
  tags = {
    Name = "subnet2"
  }
}

resource "aws_security_group" "lb" {
  name_prefix = "example-lb-"
  vpc_id      = aws_vpc.example.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "example" {
  count         = 2
  ami           = "ami-0abc123456789def0" // Replace with your desired AMI
  instance_type = "t3a.nano"
  subnet_id     = element(aws_subnet.*.id, count.index)
  user_data     = <<-EOF
    #!/bin/bash
    echo "Content-Type: text/plain"
    echo ""
    echo "\$(curl -s http://169.254.169.254/latest/meta-data/instance-id)"
  EOF

  tags = {
    Name = "example-${count.index}"
  }
}

resource "aws_launch_configuration" "example" {
  name_prefix   = "example-lc"
  image_id      = "ami-0abc123456789def0" // Replace with your desired AMI
  instance_type = "t3a.nano"
  user_data     = <<-EOF
    #!/bin/bash
    echo "Content-Type: text/plain"
    echo ""
    echo "\$(curl -s http://169.254.169.254/latest/meta-data/instance-id)"
  EOF
}

resource "aws_autoscaling_group" "example" {
  launch_configuration = aws_launch_configuration.example.id
  min_size              = 2
  max_size              = 5
  desired_capacity      = 2
  vpc_zone_identifier   = [aws_subnet.subnet1.id, aws_subnet.subnet2.id]
}

resource "aws_lb" "example" {
  name               = "example-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb.id]
  subnets            = [aws_subnet.subnet1.id, aws_subnet.subnet2.id]

  enable_deletion_protection = false

  tags = {
    Name = "example-lb"
  }
}

