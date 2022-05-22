resource "aws_key_pair" "deployer" {
  key_name = "RMIT-assignment-2-key"
  public_key = var.public_key
}

resource "aws_security_group" "allow_http_ssh" {
  description = "Allow SSH and http inbound traffic"
  vpc_id = aws_vpc.main.id

  ingress {
    description = "SSH from internet"
    from_port = 22
    protocol  = "tcp"
    to_port   = 22
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "http from internet"
    from_port = 80
    protocol  = "tcp"
    to_port   = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    protocol  = "-1"
    to_port   = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    name = "allow_http_ssh"
  }
}

resource "aws_launch_configuration" "todo_app" {
  name = web_config
  image_id      = var.ami_id
  instance_type = "t2.micro"
  security_groups = [aws_security_group.allow_http_ssh.id]

  user_data = data.template_cloudinit_config.config.rendered
  key_name = aws_key_pair.deployer.key_name
}
resource "aws_lb_target_group" "todo_app" {
  name = "todo-app-target-group"
  port = 80
  protocol = "HTTP"
  vpc_id = aws_vpc.main.id
}

resource "aws_lb" "todo_app" {
name = "todo-app-lb"
  internal = false
  load_balancer_type = "application"
  security_groups = [aws_security_group.allow_http_ssh.id]
  subnets = [aws_subnet.public_az1.id, aws_subnet.public_az2.id, aws_subnet.public_az3.id]

  tags = {
    enviroment = "production"
  }
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.todo_app.arn
  port = "80"
  protocol = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.todo_app.arn
  }
}

resource "aws_key_pair" "deployer" {
  key_name   = "rmit-assignment-2-key"
  public_key = file("/tmp/keys/ec2-key.pub")
}
data "aws_ami" "amazon-linux-2"{
  most_recent = true

  filter {
    name   = "name"
    values = [amzn2-ami-hvm-*-x86_64-ebs]
  }
  owners = ["amazon"]
}

resource "aws_security_group" "web_sg" {
  description = "Allow SSH and http inbound traffic"
  vpc_id = aws_vpc.main.id

  ingress {
    description = "SSH from internet"
    from_port = 22
    protocol  = "tcp"
    to_port   = 22
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "http from internet"
    from_port = 80
    protocol  = "tcp"
    to_port   = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    protocol  = "-1"
    to_port   = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    name = "allow_http_ssh"
  }
}
resource "aws_instance" "web"
{
  ami = var.ami_id
  instance_type = "t2.micro"
  associate_public_ip_address = true
  subnet_id = aws_subnet.private_az1.id
  key_name = aws_key_pair.deployer.key_name
  security_groups = [aws_security_group.web_sg.id]

    connection {
      type = "ssh"
      host = aws_instance.web.public_ip
    }
  }

  tags = {
    name = "RMIT Assignment 2"
    env = "demo"
  }


resource "aws_instance" "db"
{
  ami = var.ami_id
  instance_type = "t2.micro"
  associate_public_ip_address = true
  subnet_id = aws_subnet.data_az1.id
  key_name = aws_key_pair.deployer.key_name
  security_groups = [aws_security_group.db_sg.id]

  connection {
    type = "ssh"
    host = aws_instance.db.public_ip
  }
  tags = {
    name = "RMIT Assignment 2"
  }
}
