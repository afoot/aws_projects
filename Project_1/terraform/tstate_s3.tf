terraform {
  backend "s3" {
    bucket         = "aws-projects-tf-state"
    key            = "terraform/terraform.tfstate"
    region         = "var.region"
    dynamodb_table = "aws-projects-tfstate-lock"
  }
}
