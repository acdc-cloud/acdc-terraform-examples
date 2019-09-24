resource "openstack_lb_loadbalancer_v2" "lb_1" {
  vip_subnet_id = data.terraform_remote_state.network_state.outputs.subnet_id
}

resource "openstack_networking_floatingip_v2" "floatip_1" {
  pool    = "public_network"
  port_id = openstack_lb_loadbalancer_v2.lb_1.vip_port_id
}

resource "openstack_lb_listener_v2" "listener_1" {
  protocol        = "HTTP"
  protocol_port   = 80
  loadbalancer_id = "${openstack_lb_loadbalancer_v2.lb_1.id}"
}

resource "openstack_lb_pool_v2" "pool_1" {
  protocol    = "HTTP"
  lb_method   = "ROUND_ROBIN"
  listener_id = "${openstack_lb_listener_v2.listener_1.id}"
}

resource "openstack_lb_member_v2" "members" {
  count         = var.number_of_instances 
  address       = openstack_compute_instance_v2.instances[count.index].access_ip_v4
  protocol_port = 80
  pool_id  = openstack_lb_pool_v2.pool_1.id
}

