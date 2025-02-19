terraform {
  backend "s3" {
    bucket         = "aws-projects-tf-state"
    key            = "terraform"
    region         = "us-east-1"
    dynamodb_table = "aws-projects-tfstate-lock"
  }
}