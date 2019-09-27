resource "openstack_compute_secgroup_v2" "serviceB_secgroup_1" {
  name        = "serviceB-http-and-ssh"
  description = "HTTP and SSH for another awesome service"

  rule {
    from_port   = 22
    to_port     = 22
    ip_protocol = "tcp"
    cidr        = "0.0.0.0/0"
  }

  rule {
    from_port   = 80
    to_port     = 80
    ip_protocol = "tcp"
    cidr        = "0.0.0.0/0"
  }
}

