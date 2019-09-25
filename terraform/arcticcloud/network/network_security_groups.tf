resource "openstack_networking_secgroup_v2" "acdc_secgroup_1" {
  name        = "acdc-secgroup-1"
  description = "Network wide security group"
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_1" {
  direction         = "egress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 0
  port_range_max    = 0
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.acdc_secgroup_1.id
}

