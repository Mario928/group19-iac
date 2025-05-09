# Security Group resources for application ports

# Port 8001
resource "openstack_networking_secgroup_v2" "allow_8001" {
  name        = "allow-8001"
  description = "Allow inbound access on port 8001"
}

resource "openstack_networking_secgroup_rule_v2" "allow_8001" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 8001
  port_range_max    = 8001
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.allow_8001.id
}

# Port 8002 (Triton)
resource "openstack_networking_secgroup_v2" "allow_8002" {
  name        = "allow-8002"
  description = "Allow inbound access on port 8002 (Triton)"
}

resource "openstack_networking_secgroup_rule_v2" "allow_8002" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 8002
  port_range_max    = 8002
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.allow_8002.id
}

# Port 8501 (Streamlit)
resource "openstack_networking_secgroup_v2" "allow_8501" {
  name        = "allow-8501"
  description = "Allow inbound access on port 8501 (Streamlit)"
}

resource "openstack_networking_secgroup_rule_v2" "allow_8501" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 8501
  port_range_max    = 8501
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.allow_8501.id
}

# Port 3000 (Grafana)
resource "openstack_networking_secgroup_v2" "allow_3000" {
  name        = "allow-3000"
  description = "Allow inbound access on port 3000 (Grafana)"
}

resource "openstack_networking_secgroup_rule_v2" "allow_3000" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 3000
  port_range_max    = 3000
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.allow_3000.id
}

# Port 5050 (Label Studio)
resource "openstack_networking_secgroup_v2" "allow_5050" {
  name        = "allow-5050"
  description = "Allow inbound access on port 5050 (Label Studio)"
}

resource "openstack_networking_secgroup_rule_v2" "allow_5050" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 5050
  port_range_max    = 5050
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.allow_5050.id
}

# Port 8888 (Jupyter)
resource "openstack_networking_secgroup_v2" "allow_8888" {
  name        = "allow-8888"
  description = "Allow inbound access on port 8888 (Jupyter)"
}

resource "openstack_networking_secgroup_rule_v2" "allow_8888" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 8888
  port_range_max    = 8888
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.allow_8888.id
}