
variable "ec2_ami_id" {
  default = "ami-02dfbd4ff395f2a1b"
  type    = string
}

variable "ec2_default_root_storage_size" {
  default = 8
  type    = number
}

variable "ec2_root_storage_type" {
  default = "gp3"
  type    = string
}

variable "instance_type" {
  default = "t3.micro"
  type    = string
}

variable "env" {
  default = "prod"
  type    = string
}