module "global" {
  source = "../global-vars"
}

# Configure the OpenStack Provider
provider "openstack" {
  domain_name = "${module.global.domain}"
  user_name   = "${module.global.username}"
  tenant_name = "${module.global.domain}"
  auth_url    = "${module.global.auth_url}"
  region      = "RegionOne"
}

resource "openstack_compute_keypair_v2" "own-keypair" {
  name       = "my-keypair"
  public_key = "<YOURKEYPAIR>"
}
