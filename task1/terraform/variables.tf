variable "do_token" {
  description = "DigitalOcean API token"
  type        = string
  sensitive   = true
}

variable "surname" {
  description = "Your surname used for resource naming"
  type        = string
  default     = "smaluk"
}

variable "region" {
  description = "DigitalOcean region (closest to Ukraine)"
  type        = string
  default     = "fra1" # Frankfurt — найближчий до України
}

variable "vpc_ip_range" {
  description = "IP range for VPC"
  type        = string
  default     = "10.10.10.0/24"
}

variable "vm_size" {
  description = "Droplet size (must meet Minikube requirements: 2 CPU, 4GB RAM minimum)"
  type        = string
  default     = "s-2vcpu-4gb" # 2 vCPU, 4GB RAM — мінімум для Minikube
}

variable "ssh_key_fingerprint" {
  description = "SSH key fingerprint registered in DigitalOcean"
  type        = string
  sensitive   = true
}

variable "spaces_access_key" {
  description = "DigitalOcean Spaces access key (for tfstate backend)"
  type        = string
  sensitive   = true
}

variable "spaces_secret_key" {
  description = "DigitalOcean Spaces secret key (for tfstate backend)"
  type        = string
  sensitive   = true
}
