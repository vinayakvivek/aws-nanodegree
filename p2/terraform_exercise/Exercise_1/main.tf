# TODO: Designate a cloud provider, region, and credentials
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 2.70"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = "us-east-1"
}


# TODO: provision 4 AWS t2.micro EC2 instances named Udacity T2
resource "aws_instance" "t2_instances" {
  count         = 4
  ami           = "ami-0323c3dd2da7fb37d"
  instance_type = "t2.micro"
  subnet_id     = "subnet-0e098ab7156cf6ab9"
  tags = {
    "Project" = "Udacity-p2"
    "Name"    = "Udacity T2"
  }
}

# TODO: provision 2 m4.large EC2 instances named Udacity M4
# resource "aws_instance" "m4_instances" {
#   count         = 2
#   ami           = "ami-0323c3dd2da7fb37d"
#   instance_type = "m4.large"
#   subnet_id     = "subnet-0e098ab7156cf6ab9"
#   tags = {
#     "Project" = "Udacity-p2"
#     "Name"    = "Udacity M4"
#   }
# }