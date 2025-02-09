variable "region" {
    default = "us-east-1"
  }

  variable "vpc_name" {
    default = "vpc_dev"
  }

  variable "vpc_cidr" {
    default = "172.31.0.0/16"
  }

  variable "az1" {
    default = "us-east-1a"
  }

  variable "az2" {
    default = "us-east-1b"
  }

  variable "az3" {
    default = "us-east-1c"
  }

  variable "public_sub1" {
    default = "172.31.0.0/20"
  }

  variable "public_sub2" {
    default = "172.31.16.0/20"
  }

  variable "public_sub3" {
    default = "172.31.32.0/20"
  }

  variable "private_sub1" {
    default = "172.31.64.0/20"
  }

  variable "private_sub2" {
    default = "172.31.80.0/20"
  }

  variable "private_sub3" {
    default = "172.31.96.0/20"
  }

  