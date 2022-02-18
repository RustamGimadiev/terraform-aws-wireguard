terraform {
  required_providers {
    aws = {
      version = "~>3.71.0"
      source  = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = "eu-west-2"
}

module "aws-wireguard" {
  source           = "../.."
  instance_type    = "t3.micro"
  wg_group_name    = "wg-test-group"
  listen-port      = "8080"
  aws_ec2_key      = "asafin"
  prefix           = "wg"
  project-name     = "dev"
  vpc_id           = "vpc-0c65a293f10f88001"
  wireguard_subnet = "subnet-0a0f68dd1b5c8d695"
  vpn_subnet       = "10.11.12.0/24"
  users_management_type = "iam"
}

output "get_config_command" {
  value = module.aws-wireguard.get_conf_command
}