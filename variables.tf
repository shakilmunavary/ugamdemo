
variable "region" {
  description = "Region"
  default = "ap-south-1"
}

variable "accesskey" {
  description = "AWS Accesskey"
  default = "AKIAQQIEGRVXCPIR757M"
}

variable "seckey" {
  default = "ZqbnDVURByjOJui3NJJM3DfHl8z1I3Z3L9N/pO7z"
  description = "AWS Secretkey"
}

variable "ami_id" { 
  default = "ami-00bf4ae5a7909786c"
  description = "AMI_ID"
}

variable "keyname" { 
  default = "myawskey"
  description = "Key Name"
}

variable "security_group_id" { 
  default = "sg-03a7e07e"
  description = "I am using existing default SG"
}
