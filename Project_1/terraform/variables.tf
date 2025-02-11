variable "region" {
  default = "us-east-1"
}

variable "vpc_name" {
  default = "vpc_dev"
}

variable "vpc_cidr" {
  default = "172.21.0.0/16"
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
  default = "172.21.1.0/24"
}

variable "public_sub2" {
  default = "172.21.2.0/24"
}

variable "public_sub3" {
  default = "172.21.3.0/24"
}

variable "private_sub1" {
  default = "172.21.4.0/24"
}

variable "private_sub2" {
  default = "172.21.5.0/24"
}

variable "private_sub3" {
  default = "172.21.6.0/24"
}

variable "ami" {
  default = "ami-0e1bed4f06a3b463d"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "rmquser" {
  description = "rmq user"
}

variable "rmqpass" {
  description = "rmq password"
}

variable "key_name" {
  description = "aws key"
}

variable "instance_count" {
  default = 1
}

variable "user" {
  description = "user for bastion host"
}

variable "dbuser" {
  description = "username word for db"
}

variable "dbpass" {
  description = "password for db"
}

variable "dbname" {
  description = "db name"
}

variable "my_ip" {
  description = "your external ip to connect bastion host"
}

variable "private_key_path" {
  description = "Path to the private key file"
  type        = string
}

locals {
  private_key = file(var.private_key_path)
}

variable "account_id" {
  description = "AWS account ID"
}