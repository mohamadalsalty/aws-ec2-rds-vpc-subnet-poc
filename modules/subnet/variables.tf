variable "vpc_id" {
  description = "The VPC id"
}

variable "name" {
  description = "The subnet name"
}

variable "cidr_block" {
  description = "The cidr block"
  type        = string
}
variable "availability_zone" {
}