variable "instance_type" {
  description = "Instance type for the EC2 instances"
  type        = string
  default     = "t2.micro"
}

variable "instance_name" {
  description = "Name to be used for EC2 instances"
  type        = string
}