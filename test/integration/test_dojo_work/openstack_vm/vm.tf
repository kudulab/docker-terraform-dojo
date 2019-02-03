resource "openstack_compute_instance_v2" "vm" {
    availability_zone = "nova"
    name = "terraformide"
    image_name = "ubuntu-16.04-bpk-4.13-chef-12.21.1"
    # ephemeral disk is unused anyways
    flavor_name = "v.c1.m1024.d5.e5"
    key_pair = "admin"
    stop_before_destroy = true

    security_groups = ["default"]

    network {
      name="main"
    }
}
resource "null_resource" "provision_vm" {
    depends_on = ["openstack_compute_instance_v2.vm"]

    connection {
      type = "ssh"
      host = "${openstack_compute_instance_v2.vm.access_ip_v4}"
      user = "ubuntu"
      # private_key = "${file("~/.ssh/admin_id_rsa")}" # commented to make "terraform plan" work in tests
    }
    provisioner "salt-masterless" {
        "local_state_tree" = "/tmp"
        "log_level" = "debug"
    }
}
output "vm_ip" {
  value = "${openstack_compute_instance_v2.vm.access_ip_v4}"
}
