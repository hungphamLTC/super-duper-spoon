variable "area_code" {
  description = "Area code"
  type = string
}

variable "vpc_cidr" {
    description = "VPC CIDR block"
    type = string
}

variable "private_cidr" {
    description = "List of CIDR blocks for private subnet"
    type = list(string)
}

variable "public_cidr" {
    description = "List of CIDR blocks for public subnet"
    type = list(string)
}

