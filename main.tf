provider "aws" {
  region     = "ap-southeast-1"
}

module VPC {
    source     = "./VPC"
    stage_name = var.stage_name
}

module RDS{
    source = "./RDS"
    username_db = var.username_db
    password_db = var.password_db
    stage_name  = var.stage_name
}