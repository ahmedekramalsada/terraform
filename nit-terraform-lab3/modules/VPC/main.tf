data "aws_vpc" "vpc_1" {
  id = var.vpc_id
}

resource "aws_subnet" "pub_sub" {
  vpc_id            = data.aws_vpc.vpc_1.id
  cidr_block        = var.pub_sub_cider
  availability_zone = "us-east-1a"

  tags = {
    Name    = "${var.project_name}-public-subnet"
    Project = var.project_name
    Owner   = var.owner
  }
}

resource "aws_subnet" "pri_sub" {
  vpc_id            = data.aws_vpc.vpc_1.id
  cidr_block        = var.pri_sub_cider
  availability_zone = "us-east-1b"

  tags = {
    Name    = "${var.project_name}-private-subnet"
    Project = var.project_name
    Owner   = var.owner
  }
}


resource "aws_internet_gateway" "gw" {
  vpc_id = data.aws_vpc.vpc_1.id
  tags = {
    Name    = "${var.project_name}-igw"
    Project = var.project_name
    Owner   = var.owner
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = data.aws_vpc.vpc_1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = {
    Name    = "${var.project_name}-public-rt"
    Project = var.project_name
    Owner   = var.owner
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.pub_sub.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_security_group" "dynamic_sg" {
  name        = "${var.project_name}-${var.environment}-sg"
  description = "Security group for ${var.project_name} - ${var.environment}"
  vpc_id      = data.aws_vpc.vpc_1.id

  dynamic "ingress" {
    for_each = var.ingress_ports
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
      description = ingress.value.description
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }

  tags = {
    Name        = "${var.project_name}-sg-${var.environment}"
    Project     = var.project_name
    Owner       = var.owner
    Environment = var.environment
  }
}
