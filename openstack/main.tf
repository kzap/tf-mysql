provider "openstack" {
    user_name  = "${var.username}"
    tenant_name = "${var.tenant_name}"
    password = "${var.password}"
    auth_url  = "${var.auth_url}"
}

resource "openstack_compute_keypair_v2" "dbserver_keypair" {
  name = "dbserver-keypair"
  region = "${var.region}"
  public_key = "${var.public_key}"
}
/*
resource "openstack_compute_floatingip_v2" "dbserver_ip" {
  region = "${var.region}"
  pool = "${lookup(var.pub_net_id, var.region)}"
  count = "${var.servers}"
}
*/
resource "openstack_compute_instance_v2" "dbserver_node" {
  name = "dbserver-node-${count.index}"
  region = "${var.region}"
  image_id = "${lookup(var.image, var.region)}"
  flavor_id = "${lookup(var.flavor, var.region)}"
  #floating_ip = "${element(openstack_compute_floatingip_v2.dbserver_ip.*.address,count.index)}"
  key_pair = "dbserver-keypair"
  count = "${var.servers}"

    connection {
        user = "${var.user_login}"
        private_key = "${var.key_file_path}"
        timeout = "1m"
    }

    provisioner "remote-exec" {
        inline = [
            "echo ${var.servers} > /tmp/db-server-count",
            "echo ${count.index} > /tmp/db-server-index",
            "echo ${openstack_compute_instance_v2.dbserver_node.0.network.0.fixed_ip_v4} > /tmp/db-server-addr",
        ]
    }
    
    provisioner "file" {
        source = "${path.module}/scripts/provision"
        destination = "/tmp/provision"
    }
    
    provisioner "remote-exec" {
        scripts = [
            "${path.module}/scripts/provision-centos.sh",
        ]
    }
    
}
