variable "cidr_block" {
  default     = ""
  description = "Ip Range for VPC"
}

variable "vpc_name" {
  default     = ""
  description = "Specify VPCname"
}

variable "availability_zones" {
  description = "Specify availability zones"
  type        = "list"
}


