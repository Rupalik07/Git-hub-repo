

resource "aws_vpc" "krishna_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "krishna_subnet" {
  vpc_id            = aws_vpc.krishna_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "ap-south-1a" # Specify the availability zone
}
resource "aws_subnet" "krishna_subnet2" {
  vpc_id            = aws_vpc.krishna_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "ap-south-1b" # Specify the availability zone
}

resource "aws_security_group" "s3_sg" {
  vpc_id = aws_vpc.krishna_vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.0.0.0/16"] # Allow traffic from within VPC
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-krishna-bucket-name"

  tags = {
    Name = "MyBucket"
  }
}
resource "aws_security_group" "rds_sg" {
  vpc_id = aws_vpc.krishna_vpc.id

  ingress {
    from_port   = 3306
    to_port     = 3306
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

resource "aws_db_subnet_group" "krishna_db_subnet_group" {
  name       = "db-subnet-group"
  subnet_ids = [aws_subnet.krishna_subnet.id,aws_subnet.krishna_subnet2.id]
}

resource "aws_db_instance" "krishna_db_instance" {
  identifier             = "my-db-instance"
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "5.7"
  instance_class         = "db.t3.micro"
  username               = "admin"
  password               = "rupali_123"
  db_subnet_group_name   = aws_db_subnet_group.krishna_db_subnet_group.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
}
