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
