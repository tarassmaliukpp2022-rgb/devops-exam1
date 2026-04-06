# ─────────────────────────────────────────
# VPC
# ─────────────────────────────────────────
resource "digitalocean_vpc" "main" {
  name     = "${var.surname}-vpc"
  region   = var.region
  ip_range = var.vpc_ip_range
}

# ─────────────────────────────────────────
# FIREWALL
# ─────────────────────────────────────────
resource "digitalocean_firewall" "main" {
  name = "${var.surname}-firewall"

  # Прив'язуємо firewall до нашої VM
  droplet_ids = [digitalocean_droplet.main.id]

  # Inbound: дозволяємо вхідні з'єднання на порти 22, 80, 443, 8000-8003
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

  # Outbound: дозволяємо всі вихідні з'єднання (порти 1-65535)
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
  size   = var.vm_size   # s-2vcpu-4gb: 2 vCPU, 4GB RAM — вимога Minikube
  image  = "ubuntu-24-04-x64" # Ubuntu 24 LTS

  # Розміщуємо VM всередині нашого VPC
  vpc_uuid = digitalocean_vpc.main.id

  # SSH ключ для доступу до VM
  ssh_keys = [var.ssh_key_fingerprint]

  # Теги для зручної ідентифікації
  tags = ["${var.surname}", "terraform", "minikube"]
}

# ─────────────────────────────────────────
# BUCKET (Spaces Object Storage)
# ─────────────────────────────────────────
resource "digitalocean_spaces_bucket" "main" {
  name   = "${var.surname}-bucket"
  region = var.region # fra1 — ідентичний до VPC

  # acl = "private" — доступ за замовчуванням (private)
  acl = "private"

  # Версіонування об'єктів (опціонально, але корисно)
  versioning {
    enabled = true
  }
}
