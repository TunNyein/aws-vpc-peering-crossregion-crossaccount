variable "vpcs" {
  description = "Map of VPC configurations (frontend, backend, etc.)"
  type = map(object({


      vpc_cidr_address_space  = string
      vpc_prefix              = string
      vpc_environment         = string
      vpc_public_subnet_cidr  = list(string)
      vpc_private_subnet_cidr = list(string)
      instance_type           = string
      

  }))

}

#############################################################
# VPC_Peering Variables 
#############################################################

variable "vpca_prefix" {
  description = "The prefix for the vpc resources"
  default = "vpc-a"
}


variable "cross_acc_peering_region" {
  description = "Region of the accepter VPC"
  default     = "ap-northeast-1"

}
