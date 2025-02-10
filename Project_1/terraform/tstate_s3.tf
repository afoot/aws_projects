terraform {
  backend "s3" {
    bucket         = "aws-projects-tf-state"
    key            = "terraform/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "aws-projects-tfstate-lock"
  }
}
