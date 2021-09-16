# Terraform Orchestration
##  What is Terraform
### Why Terraform
#### Setting up Terraform
##### Securing AWS keys for Terraform

- Create env var to secure AWS keys
- Restart the terminal
- create a file called main.tf
- add the code to initialise terraform with provider AWS

```
provider "aws" {
  
    region = "eu-west-1"

}
```
- Let's run this code with `terraform init`

### Creating Resources on AWS
- Let's start with Launching and EC2 instance using the app AMI
- ami id ` `
- `sre_key.pem` file
- AWS keys setup is already done 
- public ip 
- type of the instance `t2micro`
  
#Let's start with Launching and EC2 instance using the app AMI
### define the resource name
```
resource "aws_instance" "app_instance" {
  ami = "ami-00e8ddf087865b27f"
  instance_type = "t2.micro"
  associate_public_ip_address = true
  tags = { 
     Name = "sre_shahrukh_terraform_app"
  }

}
```