resource "aws_instance" "default" {
  ami                         = "${var.ami}"
  availability_zone           = "${var.availability_zone}"
  instance_type               = "${var.ec2_instance_type}"
  monitoring                  = false
  key_name                    = "root"
  subnet_id                   = "ec2_staging_subnet_id"
  vpc_security_group_ids      = "${var.ec2_security_group_ids}"
  associate_public_ip_address = true
  source_dest_check           = true

  root_block_device {
    volume_type           = "gp2"
    volume_size           = 8
    delete_on_termination = true
  }

  tags {
    "Name" = "${var.ec2_tag_name}"
  }
}

resource "aws_db_instance" "default" {
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "5.6.17"
  instance_class       = "${rds_isntance_class}"
  name                 = "${rds_name}"
  username             = "foo"
  password             = "bar"
  db_subnet_group_name = "staging_db_subnet"
  parameter_group_name = "default.mysql5.6"
}

resource "aws_route53_record" "ec2_defualt" {
  zone_id = "route53_primary_zone_id"
  name    = "${ec2_dns_record_name}"
  type    = "CNAME"
  ttl     = "300"
  records = ["${aws_instance.default.public_dns}"]
}

resource "aws_route53_record" "rds_defualt" {
  zone_id = "route53_primary_zone_id"
  name    = "${rds_dns_record_name}"
  type    = "CNAME"
  ttl     = "300"
  records = ["${aws_db_instance.default.endpoint}"]
}
