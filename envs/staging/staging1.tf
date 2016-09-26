# Getting latest ubuntu 14.04 ami id
data "aws_ami" "ubuntu_latest" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/ebs/ubuntu-trusty-14.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["paravirtual"]
  }

  owners = ["099720109477"]
}

module "staging1" {
  source = "../../modules/staging"

  ec2_tag_name           = "staging1.sample-terraform"
  ami                    = "${data.aws_ami.ubuntu_latest.id}"
  ec2_security_group_ids = []

  # ec2_instance_type = "t2.small"  # no need because of default value

  rds_name            = "staging1"
  ec2_dns_record_name = "www-ec2.example.com" # awful...
  rds_dns_record_name = "www-rds.example.com"
}
