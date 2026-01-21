data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

resource "aws_instance" "pub_ec2" {
  count                       = var.instance_count >= 1 ? 1 : 0
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  subnet_id                   = var.pub_subnet_id
  vpc_security_group_ids      = [var.security_group_id]
  associate_public_ip_address = true
  key_name                    = aws_key_pair.deployer.key_name

  tags = {
    Name    = "${var.project_name}-public-ec2"
    Type    = "Public"
    Project = var.project_name
    Owner   = var.owner
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update -y",
      "sudo apt-get install -y nginx",
      "sudo tee /var/www/html/index.html > /dev/null <<'EOF'",
      "<!DOCTYPE html>",
      "<html>",
      "<head>",
      "    <title>Hello from ${var.project_name}</title>",
      "</head>",
      "<body>",
      "    <h1>Hello from ${var.project_name}</h1>",
      "    <p>Owner: ${var.owner}</p>",
      "</body>",
      "</html>",
      "EOF",

      "sudo systemctl start nginx",
      "sudo systemctl enable nginx",

      "sudo ufw --force enable",
      "sudo ufw allow 22/tcp",
      "sudo ufw allow 80/tcp",
      "sudo ufw allow 443/tcp",

      "echo 'Access your site at: http://${self.public_ip}'"
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file(pathexpand("~/.ssh/terraform-key"))
      host        = self.public_ip
      timeout     = "10m"
    }
  }

  provisioner "local-exec" {
    command = "echo 'Public instance ${self.id} created with IP ${self.public_ip}' >> ${var.project_name}-instances.log"
  }

  provisioner "local-exec" {
    command = "echo 'Web server available at: http://${self.public_ip}'"
  }
}

resource "aws_instance" "pri_ec2" {
  count                       = var.instance_count >= 1 ? 1 : 0
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  subnet_id                   = var.pri_subnet_id
  vpc_security_group_ids      = [var.security_group_id]
  associate_public_ip_address = false
  key_name                    = aws_key_pair.deployer.key_name

  tags = {
    Name    = "${var.project_name}-private-ec2"
    Type    = "Private"
    Project = var.project_name
    Owner   = var.owner
  }
}

resource "aws_key_pair" "deployer" {
  key_name   = "${var.project_name}-key"
  public_key = file(pathexpand("~/.ssh/terraform-key.pub"))

  tags = {
    Name    = "${var.project_name}-key"
    Project = var.project_name
    Owner   = var.owner
  }
}
