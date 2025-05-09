// Private network for inter-node communication
resource "openstack_networking_network_v2" "private_net" {
  name                  = "private-net-group19-${var.suffix}"
  port_security_enabled = false
}

resource "openstack_networking_subnet_v2" "private_subnet" {
  name       = "private-subnet-group19-${var.suffix}"
  network_id = openstack_networking_network_v2.private_net.id
  cidr       = "192.168.1.0/24"
  no_gateway = true
}

resource "openstack_networking_port_v2" "private_net_ports" {
  for_each              = var.nodes
  name                  = "port-${each.key}-group19-${var.suffix}"
  network_id            = openstack_networking_network_v2.private_net.id
  port_security_enabled = false

  fixed_ip {
    subnet_id  = openstack_networking_subnet_v2.private_subnet.id
    ip_address = each.value
  }
}

// Public network ports for each node with security groups
resource "openstack_networking_port_v2" "sharednet2_ports" {
  for_each   = var.nodes
  name       = "sharednet2-${each.key}-group19-${var.suffix}"
  network_id = data.openstack_networking_network_v2.sharednet2.id
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

// Node VMs
resource "openstack_compute_instance_v2" "nodes" {
  for_each    = var.nodes
  name        = "${each.key}-group19-${var.suffix}"
  image_name  = "CC-Ubuntu24.04"
  flavor_name = "m1.medium"
  key_pair    = var.key

  // Connect to the shared network
  network {
    port = openstack_networking_port_v2.sharednet2_ports[each.key].id
  }

  // Connect to the private network for inter-node communication
  network {
    port = openstack_networking_port_v2.private_net_ports[each.key].id
  }

  user_data = <<-EOF
    #! /bin/bash
    sudo echo "127.0.1.1 ${each.key}-group19-${var.suffix}" >> /etc/hosts
    su cc -c /usr/local/bin/cc-load-public-keys
  EOF
}

// Assiging floating IP
/*
resource "openstack_networking_floatingip_v2" "node1_floating_ip" {
  pool        = "public"
  description = "Floating IP for node1-group19-${var.suffix}"
  port_id     = openstack_networking_port_v2.sharednet2_ports["node1"].id
}
*/

// reusing existing floating IP from previous deployment
resource "openstack_networking_floatingip_v2" "node1_floating_ip" {
  address     = "129.114.27.144"  // existing floating IP address
  pool        = "public"
  description = "Reused Floating IP for node1-group19-${var.suffix}"
  port_id     = openstack_networking_port_v2.sharednet2_ports["node1"].id
}

// block storage for persistent data 
// Commented out original block storage
/*
resource "openstack_blockstorage_volume_v3" "blockstorage_volume" {
  name = "blockstorage-volume-${var.suffix}"
  size = 100
  enable_online_resize = true
}
*/

// Reusing existing block storage from previous deployment
resource "openstack_blockstorage_volume_v3" "blockstorage_volume" {
  name = "blockstorage-volume-project19"  // existing block storage name
  size = 100
  enable_online_resize = true
}

resource "openstack_compute_volume_attach_v2" "blockstorage_volume_attach" {
  instance_id = openstack_compute_instance_v2.nodes["node1"].id
  volume_id   = openstack_blockstorage_volume_v3.blockstorage_volume.id
}

// create object storage 
/*
resource "openstack_objectstorage_container_v1" "objectstore_container" {
  provider = openstack.swift
  name     = "object-persist-project19"
}
*/

// reusing existing object storage container
resource "openstack_objectstorage_container_v1" "objectstore_container" {
  provider = openstack.swift
  name     = "object-persist-project19"  // resusing the existing container
}

