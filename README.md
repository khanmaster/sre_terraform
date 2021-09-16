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