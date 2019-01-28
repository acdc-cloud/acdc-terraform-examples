resource "openstack_compute_secgroup_v2" "rancherMaster_secgroup" {
  name        = "rancherMaster"
  description = "HTTP and HTTPS for rancher ingress"

  rule {
    from_port   = 443
    to_port     = 443
    ip_protocol = "tcp"
    cidr        = "0.0.0.0/0"
  }

  rule {
    from_port   = 80
    to_port     = 80
    ip_protocol = "tcp"
    cidr        = "0.0.0.0/0"
  }
  rule {
    from_port   = 22
    to_port     = 22
    ip_protocol = "tcp"
    cidr        = "0.0.0.0/0"
  }
}

resource "openstack_compute_secgroup_v2" "rancher_cattle" {
  name        = "rancher-cattle"
  description = "Communication between Rancher Host and Cattle"
  rule {
    from_port   = 22
    to_port     = 22
    ip_protocol = "tcp"
    self = true
  }
  rule {
    from_port   = 443
    to_port     = 443
    ip_protocol = "tcp"
    self = true
  }

  rule {
    from_port   = 80
    to_port     = 80
    ip_protocol = "tcp"
    self = true
  }

  rule {
    from_port   = 6443
    to_port     = 6443
    ip_protocol = "tcp"
    self = true
  }

  rule {
    from_port   = 2376
    to_port     = 2376
    ip_protocol = "tcp"
    self = true
  }

  rule {
    from_port   = 2379
    to_port     = 2380
    ip_protocol = "tcp"
    self = true
  }

  rule {
    from_port   = 10250
    to_port     = 10256
    ip_protocol = "tcp"
    self = true
  }

  rule {
    from_port   = 30000
    to_port     = 32767
    ip_protocol = "tcp"
    self = true
  }

  rule {
    from_port   = 8472
    to_port     = 8472
    ip_protocol = "udp"
    self = true
  }
}