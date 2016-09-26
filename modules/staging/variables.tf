# common variables
variable "availability_zone" {
  default = "ap-northeast-1"
}

# EC2 variables
variable "ami" {}

variable "ec2_instance_type" {
  default = "t2.small"
}

variable "ec2_security_group_ids" {
  type = "list"
}

variable "ec2_tag_name" {}

# RDS variables
variable "rds_name" {}

variable "rds_isntance_class" {
  default = "db.t1.micro"
}

# Route53 variables
variable "ec2_dns_record_name" {}

variable "rds_dns_record_name" {}
