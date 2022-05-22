resource "aws_security_group" "db_group" {
  description = "Allow postgres traffic"
  vpc_id = aws_vpc.main.id

  ingress {
    description = "postgres from vpc"
    from_port = 5432
    to_port   = 5432
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    name = "Allow postgres"
  }
}

resource "aws_db_subnet_group" "db_group" {
  subnet_ids = [aws_subnet.data_az1.id, aws_subnet.data_az2.id, aws_subnet.data_az3.id]

}

resource "aws_rds_cluster" "postgresql" {
  cluster_identifier = "todo-app"
  engine = "aurora-postgresq1"
  engine_mode = "serverless"
  database_name = "app"
  master_username = "postgres"
  master_password = "password"
  port = 22
  backup_retention_period = 1
  skip_final_snapshot = true
  vpc_security_group_ids = [aws_security_group.db_sg.id]
  db_subnet_group_name = aws_db_subnet_group.db_group.name
}


resource "aws_security_group" "db_sg" {
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
    from_port = 27017
    protocol  = "tcp"
    to_port   = 27017
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
