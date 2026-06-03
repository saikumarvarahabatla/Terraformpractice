variable "ami_id" {
    default     = "ami-00e801948462f718a"
    description = "The ID of the AMI to use for the instance"
    type        = string
  
}
variable "instance_type" {
    default     = "t2.micro"
    description = "The type of instance to use"
    type        = string
}