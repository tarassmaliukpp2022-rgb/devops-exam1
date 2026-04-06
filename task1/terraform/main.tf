# ─────────────────────────────────────────
# VPC
# ─────────────────────────────────────────
resource "digitalocean_vpc" "main" {
  name     = "${var.surname}-vpc-exam"
  region   = var.region
  ip_range = var.vpc_ip_range
}

# ─────────────────────────────────────────
# FIREWALL
# ─────────────────────────────────────────
resource "digitalocean_firewall" "main" {
  name = "${var.surname}-firewall"

  droplet_ids = [digitalocean_droplet.main.id]

  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "80"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "443"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "8000"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "8001"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "8002"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "8003"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "tcp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "udp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "icmp"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
}

# ─────────────────────────────────────────
# VM (Droplet)
# ─────────────────────────────────────────
resource "digitalocean_droplet" "main" {
  name   = "${var.surname}-node"
  region = var.region
  size   = var.vm_size
  image  = "ubuntu-24-04-x64"

  vpc_uuid = digitalocean_vpc.main.id

  ssh_keys = [var.ssh_key_fingerprint]

  tags = ["${var.surname}", "terraform", "minikube"]
}

# ─────────────────────────────────────────
# BUCKET (Spaces Object Storage)
# ─────────────────────────────────────────
resource "digitalocean_spaces_bucket" "main" {
  name   = "${var.surname}-bucket"
  region = var.region

  acl = "private"

  versioning {
    enabled = true
  }
}
