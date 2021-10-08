provider "alicloud" {
}

resource "alicloud_vpc" "vpc" {
  vpc_name   = "tf_test_vpc"
  cidr_block = "172.16.0.0/16"
}

resource "alicloud_vswitch" "vsw" {
  vpc_id            = alicloud_vpc.vpc.id
  cidr_block        = "172.16.0.0/24"
  zone_id           = "cn-beijing-b"
}

resource "alicloud_security_group" "asg" {
  name = "tf_test_asg"
  vpc_id = alicloud_vpc.vpc.id
}

resource "alicloud_instance" "instance" {
  # cn-beijing
  availability_zone = "cn-beijing-b"
  security_groups = alicloud_security_group.asg.*.id
  # series III
  instance_type        = "ecs.n2.small"
  image_id             = "ubuntu_18_04_64_20G_alibase_20190624.vhd"
  instance_name        = "test_foo"
  vswitch_id = alicloud_vswitch.vsw.id
  internet_max_bandwidth_out = 10
}
