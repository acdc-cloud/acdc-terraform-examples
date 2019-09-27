# To use the our DNS Services, your Registrar needs to point
# the NS Records for your Domain to the following Nameservers
# ns1.arcticcloud.com
# ns2.arcticcloud.com
# ns3.arcticcloud.com
# ns4.arcticcloud.com

resource "openstack_dns_zone_v2" "myzone" {
  name        = "example.com."
  email       = "your@email.com"
  description = "MyZone"
  ttl         = 3600
  type        = "PRIMARY"
}

resource "openstack_dns_recordset_v2" "recordset_myzone" {
  zone_id     = openstack_dns_zone_v2.myzone.id
  name        = "rs.example.com."
  description = "An example record set"
  ttl         = 3600
  type        = "A"
  records     = ["192.168.10.55"]
}

