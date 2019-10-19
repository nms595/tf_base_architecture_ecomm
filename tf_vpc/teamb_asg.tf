########################################
# Auto Scaling Group | EC2 gatekeeper 
# - Launch Configuration 
# - Template file 
# - Autoscaling Group 
# - Security Grup 
# - Sec G rules 
# - Optional 
#########################################

#########################################
# POST BOOT SCRIPT 
#########################################
data "template_file" "dm_custom_userdata_ds" {
  template = "${file("${path.module}/templates/teamb.sh")}"
}

data "template_cloudinit_config" "dm_userd_cloud_ds" {
  gzip          = true
  base64_encode = true

  part {
    content_type = "text/x-shellscript"
    content      = "${data.template_file.dm_custom_userdata_ds.rendered}"
  }
}


###### Specific to Bastion Host
resource "aws_launch_configuration" "dm_wfe_lc_res" {
  name_prefix                 = "Pub_Webserver-"
  image_id                    = "ami-3548444c"
  instance_type               = "t2.micro"
  key_name                    = "dm-kliuch"
  enable_monitoring           = true
  security_groups             = ["${aws_security_group.dm_teamb_wfe_sg_res.id}"]
  associate_public_ip_address = true

  user_data = "${data.template_cloudinit_config.dm_userd_cloud_ds.rendered}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "sm_pub_webserver_asg_res" {
  name                 = "${aws_launch_configuration.dm_wfe_lc_res.name}-asg"
  min_size             = "1"
  max_size             = "1"
  desired_capacity     = "1"
  health_check_type    = "EC2"
  launch_configuration = "${aws_launch_configuration.dm_wfe_lc_res.name}"
  vpc_zone_identifier  = "${aws_subnet.dm_sn_pub_res.*.id}"

  #   tags = [
  #     {
  #       key                = "Name"
  #       value              = "Pub_Webserver"
  #       propagate_at_launch = true
  #     },
  #   ]

  lifecycle {
    create_before_destroy = true
  }
}
