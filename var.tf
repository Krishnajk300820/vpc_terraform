variable "vpc_cidr" {
    type = string
    description = "VPC CIDR BLOCK IN THE PRIVATE ADDRESS SPACE"
    default = "10.0.0.0/20"
}

variable "public_subnet_cidr" {
    type = string
    description = "PUBLIC SUBNET CIDR BLOCK"
    default = "10.0.0.0/21"
}

variable "private_subnet_cidr" {
    type = string
    description = "PRIVATE SUBNET CIDR BLOCK"
    default = "10.0.8.0/21"
}

variable "region" {
    type = string
    description = "AWS Region"
    default = "us-east-2"
}

variable "all_ip" {
    type = string
    description = "ALL IP ADDRESSES"
    default = "0.0.0.0/0"
}


