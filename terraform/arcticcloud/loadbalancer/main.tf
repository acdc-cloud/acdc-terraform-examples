module "global" {
  source = "../../global-vars"
}

module "region" {
  source = "../region-vars"
}

# Configure the OpenStack Provider
provider "openstack" {
  domain_name = module.global.domain
  user_name   = module.global.username
  tenant_name = module.global.domain
  auth_url    = module.global.auth_url
  region      = "RegionOne"
  use_octavia = true
}

data "openstack_images_image_v2" "ubuntu" {
  name        = "Ubuntu 18.04 (bionic)"
  most_recent = true
}

data "terraform_remote_state" "network_state" {
  backend = "local"

  config = {
    path = "../network/terraform.tfstate"
  }
}

