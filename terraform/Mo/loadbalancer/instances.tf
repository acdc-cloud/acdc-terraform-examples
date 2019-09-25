resource "openstack_compute_instance_v2" "instances" {
  count           = var.number_of_instances
  name            = "instance-${count.index}"
  flavor_name     = "g1.small"
  key_pair        = "my-keypair"
  security_groups = [openstack_compute_secgroup_v2.secgroup_1.name]

  block_device {
    uuid                  = openstack_blockstorage_volume_v3.instance_root_volumes[count.index].id
    source_type           = "volume"
    boot_index            = 0
    destination_type      = "volume"
    delete_on_termination = true
  }

  user_data = file("scripts/userdata.tpl")

  network {
    name = "acdc-1"
  }

  depends_on = [openstack_blockstorage_volume_v3.instance_root_volumes]
}

resource "openstack_blockstorage_volume_v3" "instance_root_volumes" {
  count    = var.number_of_instances
  name     = "instance-${count.index}-root-volume"
  size     = 30
  image_id = data.openstack_images_image_v2.ubuntu.id
}

