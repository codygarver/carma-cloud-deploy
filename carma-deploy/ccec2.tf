resource "aws_instance" "carmaCloudTest" {
  ami   = "ami-00eeedc4036573771"
  count=1
  key_name = "myJune222Key"
  instance_type = "t2.micro"
  security_groups = ["security_jenkins_port"]
  tags = {
    Name = "jenkins_instance"
  }
}

#Create security group with firewall rules
resource "aws_security_group" "security_jenkins_port" {
  name        = "security_jenkins_port"
  description = "security group for jenkins"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

 ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

 # outbound from Jenkins server
  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags= {
    Name = "security_jenkins_port"
  }
}

# Create Elastic IP address
resource "aws_eip" "myElasticIP" {
  vpc      = true
  instance = aws_instance.carmaCloudTest
tags= {
    Name = "jenkins_elastic_ip"
  }
}
