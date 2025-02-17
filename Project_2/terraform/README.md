# Terraform ECS Project

This project sets up an AWS ECS infrastructure using Terraform. It includes the creation of an ECR repository, ECS cluster, ECS task definition, and ECS service.

## Project Structure

```
terraform
├── modules
│   ├── ecr
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   ├── variables.tf
│   ├── ecs-cluster
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   ├── variables.tf
│   ├── ecs-task-definition
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   ├── variables.tf
│   └── ecs-service
│       ├── main.tf
│       ├── outputs.tf
│       ├── variables.tf
├── main.tf
├── outputs.tf
├── variables.tf
├── provider.tf
└── README.md
```

## Prerequisites

- Terraform installed on your local machine.
- AWS account with appropriate permissions to create ECS resources.
- AWS CLI configured with your credentials.

## Setup Instructions

1. Clone the repository:
   ```
   git clone <repository-url>
   cd terraform-ecs-project
   ```

2. Update the `variables.tf` files in the modules to customize your infrastructure as needed.

3. Initialize Terraform:
   ```
   terraform init
   ```

4. Plan the deployment:
   ```
   terraform plan
   ```

5. Apply the configuration:
   ```
   terraform apply
   ```

6. After the deployment is complete, you can find the outputs in the terminal or in the `outputs.tf` file.

## Usage Guidelines

- Modify the `main.tf` file to adjust the module calls as necessary for your specific use case.
- Use the outputs from each module to reference resources created by Terraform in other parts of your infrastructure.

## Cleanup

To destroy the resources created by this project, run:
```
terraform destroy
```

This will remove all resources defined in the Terraform configuration.