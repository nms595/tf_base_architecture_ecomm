######################################
# Multiple SGs defined here 
# - ssh 
# - egress
######################################

# Default ssh 22 
resource "aws_security_group" "dm_teamb_wfe_sg_res" {
  name_prefix = "Pub_Webserver"
  description = "Allow inbound to webserver on vpc ${aws_vpc.dm_vpc_res.id} VPC"
  vpc_id      = "${aws_vpc.dm_vpc_res.id}"

  lifecycle {
    create_before_destroy = "true"
  }
}

resource "aws_security_group_rule" "dm_ssh_ingress_res" {
  type              = "ingress"
  to_port           = "22"
  from_port         = "22"
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.dm_teamb_wfe_sg_res.id}"
}

resource "aws_security_group_rule" "dm_http_ingress_res" {
  type              = "ingress"
  to_port           = "80"
  from_port         = "80"
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.dm_teamb_wfe_sg_res.id}"
}

resource "aws_security_group_rule" "dm_sg_egress_res" {
  type              = "egress"
  to_port           = "0"
  from_port         = "0"
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.dm_teamb_wfe_sg_res.id}"
}
