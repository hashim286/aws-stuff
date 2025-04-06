variable "vpc_id" {
  description = "VPC ID for the route table"
  type        = string
}

variable "igw_id" {
  description = "id for the igw to add routing"
  type        = string
}

variable "subnet_id" {
  description = "db subnet id"
  type        = string
}