variable "ami_id" {
    description = "The ID of the AMI to use for the instance"
    type        = string
    default     = "" # Example AMI ID, replace with your desired AMI
  
}
variable "instance_type" {
    description = "The type of instance to use"
    type        = string
    default     = "" # Example instance type, replace with your desired instance type
}
