provider "alicloud" {}
resource "alicloud_vpc" "vpc" {
  name       = "tf_test_foo"
  cidr_block = "172.16.0.0/12"
}

resource "alicloud_security_group" "default" {
  name = "default"
  vpc_id = alicloud_vpc.vpc.id
}

resource "alicloud_instance" "instance" {
  # cn-beijing
  availability_zone = "{$var.az}"
  security_groups = alicloud_security_group.default.*.id
  # series III
  instance_type        = "ecs.n4.small"
  system_disk_category = "cloud_efficiency"
  image_id             = "centos_7_05_64_20G_alibase_20181210.vhd"
  instance_name        = "test_foo"
}
