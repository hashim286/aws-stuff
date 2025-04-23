variable "subnet_ids" {
  description = "subnet id for the db"
  type        = list(any)
}

variable "az" {
  description = "az for the db"
  type        = string
}

variable "sec_group_id" {
  description = "security group for db"
  type        = string
}

variable "master_password" {
  description = "master password for the db"
  type        = string
}

variable "master_username" {
  description = "master username for the db"
  type        = string
}