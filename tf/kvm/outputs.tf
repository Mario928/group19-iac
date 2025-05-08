output "vm_name" {
  value       = openstack_compute_instance_v2.main_vm.name
  description = "Name of the deployed VM"
}

output "network_port_name" {
  value       = openstack_networking_port_v2.main_vm_port.name
  description = "Name of the VM's network port"
}

output "floating_ip_address" {
  value       = openstack_networking_floatingip_v2.main_vm_floating_ip.address
  description = "Public IP to reach the VM"
}

output "ssh_command" {
  value       = "ssh -i ~/.ssh/group19-shared-key cc@${openstack_networking_floatingip_v2.main_vm_floating_ip.address}"
  description = "SSH command to connect to the VM"
}

output "block_volume_name" {
  value       = openstack_blockstorage_volume_v3.blockstorage_volume.name
  description = "Name of the persistent block volume"
}

output "object_storage_container" {
  value       = openstack_objectstorage_container_v1.objectstore_container.name
  description = "Name of the object storage container"
}

output "ssh_key_used" {
  value       = var.key
  description = "SSH key name used for this deployment"
}

