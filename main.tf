provider "aws" {
  region  = var.aws_region
  profile = "default"
}
resource "aws_instance" "my-ec2-vm" {
  ami                    = var.ec2_ami_id
  instance_type          = var.itype
  count                  = var.ec2_instance_count
  user_data              = <<-EOF
    #!/bin/bash
    sudo yum update -y
    sudo yum install httpd -y
    sudo systemctl enable httpd
    sudo systemctl start httpd
    echo "<h1>Welcome to Terraform ! AWS Infra  using Terraform </h1>" > /var/www/html/index.html
    EOF
  vpc_security_group_ids = [aws_security_group.vpc-ssh.id, aws_security_group.vpc-web.id]
  tags = {
    "Name" = "myec2"
  }
}
 
# Creating security group
# Create Security Group - SSH Traffic
resource "aws_security_group" "vpc-ssh" {
  name        = var.sg1
  description = "Dev VPC SSH"
  ingress {
    description = "Allow Port 22"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "Allow all IP and Ports outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
 
# Create Security Group - Web Traffic
resource "aws_security_group" "vpc-web" {
  name        = var.sg2
  description = "Dev VPC Web"
 
  ingress {
    description = "Allow Port 80"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
 
  ingress {
    description = "Allow Port 443"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
 
  egress {
    description = "Allow all IP and Ports outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
# variables
variable "aws_region" {
  description = "Region in which AWS resources to be created"
  type        = string
  default     = "eu-central-1"
}
 
variable "ec2_ami_id" {
  description = "AMI ID"
  type        = string
  default     = "ami-065deacbcaac64cf2" # Amazon2 Linux AMI ID
}
 
variable "ec2_instance_count" {
  description = "EC2 Instance Count"
  type        = number
  default     = 1
}
variable "itype" {
  description = "instance type"
  type        = string
  default     = "t2.micro"
}
 variable "sg1" {
  description = "instance type"
  type        = string
  default     = "sg1"
}
variable "sg2" {
  description = "instance type"
  type        = string
  default     = "sg2"
}
#output

output "public_ip" {
  value = aws_instance.my-ec2-vm.*.public_ip
}
 
output "ec2_ID" {
  value = aws_instance.my-ec2-vm.*.id
}
 
output "ec2-arn" {
  value = aws_instance.my-ec2-vm.*.arn
}
 
output "private-ip" {
  value = aws_instance.my-ec2-vm.*.private_ip
}
 


 
 
