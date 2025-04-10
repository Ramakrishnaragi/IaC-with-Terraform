    # TASK 3 : Infrastructure as Code (IaC) with Terraform
    
## Objective
- Provision and manage a Docker container on your local system using Terraform
## Tools Required:
- Terraform – to define and manage infrastructure using code.
- Docker – to run the containerized application locally.
## Architecture Diagram
![Image](https://github.com/user-attachments/assets/f8379019-abe6-4c64-9705-3cf1521bc8a6)
## Step-by-step:
- Create a custom workspace in terraform(terraform workspace new <workspace_name>)
- Define the code first
        - Main.tf
        - Backend.tf
        - .gitignore
  
- Main.tf
```sh
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.2"
    }
  }
}

provider "docker" {}

resource "docker_image" "nginx" {
  name = "nginx:latest"
}

resource "docker_container" "nginx" {
  name  = "my-nginx"
  image = docker_image.nginx.name
  ports {
    internal = 80
    external = 81
  }
}
```

- Backend.tf
```sh
# Run first terraform-10-30am/day-4-resources_for_backend_s3_dynamodb to create reources 
# This backend configuration instructs Terraform to store its state in an S3 bucket.
 terraform {
backend "s3" {
    bucket         = "bucket_name"  # Name of the S3 bucket where the state will be stored.
    region         =  "region_name"
    key            = "terraform.tfstate" # Path within the bucket where the state will be read/written.
    encrypt        = true  # Ensures the state is encrypted at rest in S3.
}
}
```

- .gitignore
```sh
# Local .terraform directories
**/.terraform/*
# Terraform state files
*.tfstate
*.tfstate.*
# Terraform lock file
.terraform.lock.hcl
# documents
*.doc
```
- Initialize Terraform where the main.tf file located ---> terraform init --------> .terraform (plugins)
![Image](https://github.com/user-attachments/assets/d4a4b54f-8404-46c4-a6c1-06bf8e564e21)
- Check the blue print of the code ---->	 terraform plan
- To actually create the Docker image and container --> terraform apply -auto-approve ![Image](https://github.com/user-attachments/assets/7e8280d4-86ff-4075-93a3-02f9fcd7f119)
- The container is running in localhost
- Access the application ------> http://<localhost>:8080
![Image](https://github.com/user-attachments/assets/9cb21544-39d5-4075-8ea4-1b76473a407f)
- Check the terraform.tfstate file in s3
![Image](https://github.com/user-attachments/assets/483e021f-5b40-46d7-9c5e-f600c9f13e2f)
- Check once plan and before destroy
![Image](https://github.com/user-attachments/assets/ef3909fa-bb3b-4ad3-998f-386ff942ac71)
- Check list of the docker containers
![Image](https://github.com/user-attachments/assets/b9096bde-d51f-4586-b815-9dcaf2b05803)
- Check the terraform state
![Image](https://github.com/user-attachments/assets/881a8d15-0acb-4999-aed5-eae4b9ac7022)
- Then do destroy the resources ----> terraform destroy -auto-approve
## Benefits:
- Automate container management with Terraform
  
