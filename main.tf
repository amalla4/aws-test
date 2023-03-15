//generate terraform code to create a aws security group that allows ssh, http and https traffic

provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "allow_ssh_http_https" {
  name        = "allow_ssh_http_https"
  description = "Allow SSH(only local), HTTP and HTTPS traffic"
  vpc_id      = "yourVPCHere"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["yourIPHere/32"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
  }

    ingress {
        description = "HTTPS"
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
    }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

//ec2 instance with the security group created above
resource "aws_instance" "ec2" {
  ami           = "ami-0c2b8ca1dad447f8a"
  instance_type = "t2.micro"
  security_groups = [aws_security_group.allow_ssh_http_https.name]
  
  //user data to install httpd and start the service
    user_data = <<EOF
                #!/bin/bash
                yum update -y
                yum -y install httpd
                systemctl start httpd
                systemctl enable httpd
                echo "Hello World from Terraform" > /var/www/html/index.html
                EOF

    tags = {
        Name = "terraform-ec2"
    }
}

//output the security group id
output "security_group_id" {
  value = aws_security_group.allow_ssh_http_https.id
}