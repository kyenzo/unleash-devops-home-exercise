provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "evgeni_sg" {
  vpc_id = aws_vpc.evgeni_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
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

# Create ECS Cluster
resource "aws_ecs_cluster" "evgeni_ecs_cluster" {
  name = "evgeni-ecs-cluster"
}

resource "aws_iam_role" "ecs_instance_role" {
  name = "ecs-instance-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "ecs_instance_policy_attach" {
  role       = aws_iam_role.ecs_instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_instance_profile" "ecs_instance_profile" {
  name = "ecs_instance_profile"
  role = aws_iam_role.ecs_instance_role.name
}

resource "aws_instance" "ecs_instance" {
  count                 = 2
  ami                   = "ami-0a313d6098716f372"  # Ubuntu 20.04 LTS (us-east-1)
  instance_type         = "t3.micro"
  subnet_id             = aws_subnet.evgeni_subnet.id
  security_groups       = [aws_security_group.evgeni_sg.id]
  iam_instance_profile  = aws_iam_instance_profile.ecs_instance_profile.name
  key_name              = "evgeni-unleash-instance-key"

  user_data = <<-EOF
              #!/bin/bash
              sudo apt update
              sudo apt install -y ecs-init
              sudo systemctl enable --now ecs
              echo ECS_CLUSTER=${aws_ecs_cluster.evgeni_ecs_cluster.name} >> /etc/ecs/ecs.config
              EOF

  tags = {
    Name = "evgeni-ecs-node"
  }
}
