resource "openstack_lb_loadbalancer_v2" "lb_1" {
  vip_subnet_id = data.terraform_remote_state.network_state.outputs.subnet_id
}

resource "openstack_networking_floatingip_v2" "floatip_1" {
  pool    = "public_network"
  port_id = openstack_lb_loadbalancer_v2.lb_1.vip_port_id
}

resource "openstack_lb_listener_v2" "listener_1" {
  # If you want to terminate HTTPS on the loadbalancer, set protocol to "TERMINATED_HTTPS" and protocol_port to 443.
  # You will also have to set default_tls_container_ref to the href of a secret containing
  # a base64 encoded pkcs12 encoded certificate bundle.
  # openssl pkcs12 -export -inkey server.key -in server.crt -certfile ca-chain.crt -passout pass: -out server.p12
  # openstack secret store --name='certificate_bundle' -t 'application/octet-stream' -e 'base64' --payload="$(base64 < server.p12)"
  # openstack secret list

  protocol        = "HTTP"
  #default_tls_container_ref = <secret_href>
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

