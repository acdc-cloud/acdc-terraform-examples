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
}

# Create a private container
resource "openstack_objectstorage_container_v1" "demo_private_container" {
  region = "RegionOne"
  name   = "demo"
}

# Create a public container that is world readable
resource "openstack_objectstorage_container_v1" "demo_public_container" {
  region = "RegionOne"
  name   = "demo-public"

  container_read = ".r:*,.rlistings"
}

# Although it is possible to manage objects in containers with terraform, it is very tedious
# and usually better accomplished by using some other tools, like the swift and s3cmd tools,
# as files in containers are not really considered infrastructure
