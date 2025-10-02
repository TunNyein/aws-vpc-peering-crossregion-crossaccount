

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

variable "vpc_public_subnet_cidr" {
  type         = list(string)
  description  = "The CIDR block for the hub public subnets."
  default      = []
}

variable "instance_type" {
  description = "The type for the public ec2."
  default     = ""
}


#############################################################
# Hub App Variables
#############################################################

variable "placeholder" {
  default     = "placedog.net"
  description = "Image-as-a-service URL. Some other fun ones to try are fillmurray.com, placecage.com, placebeard.it, loremflickr.com, baconmockup.com, placeimg.com, placebear.com, placeskull.com, stevensegallery.com, placedog.net"
}

variable "placeholder_id" {
  default     = "2"
  description = "Image-as-a-service URL. Some other fun ones to try are fillmurray.com, placecage.com, placebeard.it, loremflickr.com, baconmockup.com, placeimg.com, placebear.com, placeskull.com, stevensegallery.com, placedog.net"
}

variable "width" {
  default     = "600"
  description = "Image width in pixels."
}

variable "height" {
  default     = "400"
  description = "Image height in pixels."
}
