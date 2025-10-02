

variable "vpc_cidr_address_space" {
  description = "The CIDR block of VPC"
  default     = ""
}

variable "vpc_prefix" {
  description = "The prefix for the vpc resources"
  default = ""
}


variable "vpc_environment" {
  description = "The environment for the hub resources."
  default     = ""
}

variable "vpc_private_subnet_cidr" {
  type         = list(string)
  description  = "The CIDR block for the hub private subnets."
  default      = []
}

variable "instance_type" {
  description = "The type for the public ec2."
  default     = ""
}

