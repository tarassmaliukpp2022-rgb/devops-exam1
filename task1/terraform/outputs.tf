output "vpc_id" {
  description = "VPC ID"
  value       = data.digitalocean_vpc.main.id
}

output "vpc_ip_range" {
  description = "VPC IP range"
  value       = data.digitalocean_vpc.main.ip_range
}

output "firewall_id" {
  description = "Firewall ID"
  value       = digitalocean_firewall.main.id
}

output "droplet_id" {
  description = "VM (Droplet) ID"
  value       = digitalocean_droplet.main.id
}

output "droplet_ip" {
  description = "VM public IP address"
  value       = digitalocean_droplet.main.ipv4_address
}

output "bucket_name" {
  description = "Spaces bucket name"
  value       = digitalocean_spaces_bucket.main.name
}

output "bucket_domain" {
  description = "Spaces bucket domain"
  value       = digitalocean_spaces_bucket.main.bucket_domain_name
}
