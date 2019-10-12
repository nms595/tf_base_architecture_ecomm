#########################################################
# VPC setup for our DC 
# https://www.terraform.io/docs/providers/aws/r/ami.html
#########################################################
resource "aws_vpc" "dm_vpc_res" {
  cidr_block = "10.20.0.0/16"

  tags = {
    "Name" = "dev_env"
  }

}

########################################################
# Internet Gateway for your DC 
########################################################
resource "aws_internet_gateway" "dm_igw_res" {
  vpc_id = "${aws_vpc.dm_vpc_res.id}"


  tags = {
    Name = "dev_env"
  }
}
