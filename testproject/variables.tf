variable "region" {
  description = "AWS region"
  default     = "ap-south-1"
}

variable "cidr_block" {
  description = "VPC CIDR block"
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr_blocks" {
  description = "CIDR blocks for the public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidr_blocks" {
  description = "CIDR blocks for the private subnets"
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}
variable "az" {
  description = "default az"
  type        = list(string)
  default     = ["ap-south-1a", "ap-south-1b"]
}
