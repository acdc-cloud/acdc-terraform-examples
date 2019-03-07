data "template_file" "systemd_script" {
  template = "${file("${path.module}/scripts/rancher_service.tpl")}"

  vars {
    rancher_version = "stable"
    rancher_https_port    = "443"
    rancher_http_port    = "80"    
  }
}

# Render a multi-part cloudinit config making use of the part
# above, and other source files
data "template_cloudinit_config" "config" {
  gzip          = true
  base64_encode = true

  part {
    filename     = "rancher.conf"
    content_type = "text/x-shellscript"
    content      = "${data.template_file.systemd_script.rendered}"
  }

  part {
    filename     = "setup-ranchermaster.sh"
    content_type = "text/x-shellscript"
    content      = "${file("${path.module}/scripts/userdata.tpl")}"
  }
}