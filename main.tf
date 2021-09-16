# Let's set up our could provider with Terraform

provider "aws" {
  region = "eu-west-1"
}

 #Let's start with Launching and EC2 instance using the app AMI
# define the resource name

resource "aws_instance" "app_instance" {
  ami = "ami-00e8ddf087865b27f"
  instance_type = "t2.micro"
  associate_public_ip_address = true
  tags = { 
     Name = "sre_shahrukh_terraform_app"
  }
  key_name = "sre_key" # this key name needs to the as .pem file
  #aws_key_path = var.aws_key_path
}


# step1 create a vpc with your CDIR block
# run terraform plan then terraform apply
# get the vpc id from aws or terraform logs


# Let's create our VPC
resource "aws_vpc" "sre_terraform_vpc" {
  cidr_block       = var.cidr_block 
  #"10.0.0.0/16"
  instance_tenancy = "default"
  
  tags = {
    Name = var.vpc_name
  }
} 

# Creatind Subnet for app
resource "aws_subnet" "sre_shahrukh_app_subnet" {

	vpc_id = aws_vpc.terraform_vpc.id
	cidr_block = "10.0.1.0/24"
	map_public_ip_on_launch = "true"  # Makes this a public subnet
	availability_zone = "eu-west-1a"

	tags = {
		Name = "sre_shahrukh_terraform_app"
	}

 }

# Security Groups
 resource "aws_security_group" "app_group"  {
  name = "sre_shahrukh_app_sg_terraform"
  description = "sre_shahrukh_app_sg_terraform"
  vpc_id = var.vpc_id # attaching the SG with your own VPC

# Inbound rules
  ingress {
    from_port       = "80"
    to_port         = "80"
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]   
  }

# ssh access 
  ingress {
    from_port       = "22"
    to_port         = "22"
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]  
  }

# allow port 3000

ingress {
    from_port       = "3000"
    to_port         = "3000"
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]  
  }

# Outbound rules
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1" # allow all
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sre_shahrukh_app_sg_terraform"
  }
}
