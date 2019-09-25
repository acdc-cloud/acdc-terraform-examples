resource "openstack_compute_instance_v2" "serviceB" {
  name            = "serviceB"
  flavor_name     = "g1.small"
  key_pair        = "my-keypair"
  security_groups = ["acdc-secgroup-1", openstack_compute_secgroup_v2.serviceB_secgroup_1.name]

  availability_zone = "SV2"

  block_device {
    uuid                  = openstack_blockstorage_volume_v3.serviceB_root_volume.id
    source_type           = "volume"
    boot_index            = 0
    destination_type      = "volume"
    delete_on_termination = true
  }

  user_data = file("scripts/userdata.tpl")

  network {
    name = module.region.regional_public_network_name
  }

  depends_on = [openstack_blockstorage_volume_v3.serviceB_root_volume]
}

resource "openstack_blockstorage_volume_v3" "serviceB_root_volume" {
  name     = "serviceB-root-volume"
  size     = 30
  image_id = data.openstack_images_image_v2.ubuntu.id

  availability_zone = "SV2"
}

resource "openstack_networking_floatingip_v2" "serviceB_floatip_1" {
  pool = "public_network"
}

resource "openstack_compute_floatingip_associate_v2" "serviceB_fip_attachment" {
  floating_ip = openstack_networking_floatingip_v2.serviceB_floatip_1.address
  instance_id = openstack_compute_instance_v2.serviceB.id
}

# #If a DNS record is desired. The DNS Zone needs to exist first 
# resource "openstack_dns_recordset_v2" "recordset_myzone" {
#   zone_id = "${openstack_dns_zone_v2.myzone.id}"
#   name = "rs.example.com."
#   description = "An example record set"
#   ttl = 3600
#   type = "A"
#   records = ["${openstack_networking_floatingip_v2.serviceB_floatip_1.address}"]
# }
