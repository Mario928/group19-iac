resource "openstack_networking_port_v2" "main_vm_port" {
  name       = "main-vm-port-${var.suffix}"
  network_id = data.openstack_networking_network_v2.sharednet3.id
  security_group_ids = [
    data.openstack_networking_secgroup_v2.allow_ssh.id,
    data.openstack_networking_secgroup_v2.allow_8000.id,
    data.openstack_networking_secgroup_v2.allow_9000.id,
    data.openstack_networking_secgroup_v2.allow_9001.id,
    data.openstack_networking_secgroup_v2.allow_8080.id,
    data.openstack_networking_secgroup_v2.allow_8081.id,
    data.openstack_networking_secgroup_v2.allow_http_80.id,
    data.openstack_networking_secgroup_v2.allow_9090.id,
    openstack_networking_secgroup_v2.allow_8001.id,
    openstack_networking_secgroup_v2.allow_8002.id,
    openstack_networking_secgroup_v2.allow_8501.id,
    openstack_networking_secgroup_v2.allow_3000.id,
    openstack_networking_secgroup_v2.allow_5050.id,
    openstack_networking_secgroup_v2.allow_8888.id,
  ]
}

resource "openstack_compute_instance_v2" "main_vm" {
  name        = "main-vm-${var.suffix}"
  image_name  = "CC-Ubuntu24.04"
  flavor_name = "m1.medium"
  key_pair    = var.key

  network {
    port = openstack_networking_port_v2.main_vm_port.id
  }

  user_data = <<-EOF
    #! /bin/bash
    sudo echo "127.0.1.1 main-vm-${var.suffix}" >> /etc/hosts
    su cc -c /usr/local/bin/cc-load-public-keys
  EOF
}

resource "openstack_networking_floatingip_v2" "main_vm_floating_ip" {
  pool        = "public"
  description = "Floating IP for main-vm-${var.suffix}"
  port_id     = openstack_networking_port_v2.main_vm_port.id
}

resource "openstack_blockstorage_volume_v3" "blockstorage_volume" {
  name = "blockstorage-volume-${var.suffix}"
  size = 20
  // availability_zone = "KVM@TACC"  
}

resource "openstack_compute_volume_attach_v2" "blockstorage_volume_attach" {
  instance_id = openstack_compute_instance_v2.main_vm.id
  volume_id   = openstack_blockstorage_volume_v3.blockstorage_volume.id
}

resource "openstack_objectstorage_container_v1" "objectstore_container" {
  provider = openstack.swift
  name     = "object-persist-project19"
}

