vpcs = {
  vpc-a = {
    vpc_cidr_address_space = "10.10.0.0/16"
    vpc_prefix             = "vpc-a"
    vpc_environment        = "prod"
    vpc_public_subnet_cidr = ["10.10.11.0/24"]
    vpc_private_subnet_cidr= ["10.10.21.0/24"]
    instance_type          = "t2.micro"
    
  }

  vpc-b = {
    vpc_cidr_address_space = "172.168.0.0/16"
    vpc_prefix             = "vpc-b"
    vpc_environment        = "prod"
    vpc_public_subnet_cidr = ["172.168.11.0/24"]
    vpc_private_subnet_cidr= ["172.168.21.0/24"]
    instance_type          = "t2.micro"
    
  }

  vpc-c = {
    vpc_cidr_address_space = "192.168.0.0/16"
    vpc_prefix             = "vpc-c"
    vpc_environment        = "prod"
    vpc_public_subnet_cidr = ["192.168.11.0/24"]
    vpc_private_subnet_cidr= ["192.168.21.0/24"]
    instance_type          = "t2.micro"
    
  }

}
