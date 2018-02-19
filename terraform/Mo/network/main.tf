module "global" {
  source = "../../global-vars"
}

# Configure the OpenStack Provider
provider "openstack" {
  domain_name = "${module.global.domain}"
  user_name   = "${module.global.username}"
  tenant_name = "${module.global.domain}"
  auth_url    = "${module.global.auth_url}"
  region      = "RegionOne"
}

data "openstack_networking_network_v2" "public_network" {
  name = "public_network"
}
