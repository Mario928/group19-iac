data "openstack_networking_network_v2" "sharednet3" {
  name = "sharednet3"
}

data "openstack_networking_secgroup_v2" "allow_ssh" {
  name = "allow-ssh"
}

data "openstack_networking_secgroup_v2" "allow_8000" {
  name = "allow-8000"
}

data "openstack_networking_secgroup_v2" "allow_9000" {
  name = "allow-9000"
}

data "openstack_networking_secgroup_v2" "allow_9001" {
  name = "allow-9001"
}

data "openstack_networking_secgroup_v2" "allow_8080" {
  name = "allow-8080"
}

data "openstack_networking_secgroup_v2" "allow_8081" {
  name = "allow-8081"
}

data "openstack_networking_secgroup_v2" "allow_http_80" {
  name = "allow-http-80"
}

data "openstack_networking_secgroup_v2" "allow_9090" {
  name = "allow-9090"
}

data "openstack_networking_secgroup_v2" "allow_8001" {
  name = "allow-8001"
}

data "openstack_networking_secgroup_v2" "allow_8002" {
  name = "allow-8002"
}

data "openstack_networking_secgroup_v2" "allow_8501" {
  name = "allow-8501"
}

data "openstack_networking_secgroup_v2" "allow_3000" {
  name = "allow-3000"
}

data "openstack_networking_secgroup_v2" "allow_5050" {
  name = "allow-5050"
}

data "openstack_networking_secgroup_v2" "allow_8888" {
  name = "allow-8888"
}


