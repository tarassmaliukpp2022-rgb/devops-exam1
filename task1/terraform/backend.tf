terraform {
  required_version = ">= 1.0"

  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }

  # tfstate зберігається у DigitalOcean Spaces (S3-сумісне сховище)
  # Це виконує вимогу: "tfstate-файл повинен бути розміщений у хмарі"
  backend "s3" {
    endpoint = "https://fra1.digitaloceanspaces.com" # регіон Frankfurt
    region   = "us-east-1" # обов'язкове поле для S3-сумісного backend, але ігнорується DO

    bucket = "terraform-state-smaluk" # назва твого Spaces bucket (створений вручну)
    key    = "task1/terraform.tfstate" # шлях до файлу всередині bucket

    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    force_path_style            = true

    # Ключі передаються через змінні середовища:
    # AWS_ACCESS_KEY_ID     = Spaces Access Key
    # AWS_SECRET_ACCESS_KEY = Spaces Secret Key
  }
}

provider "digitalocean" {
  token = var.do_token
}
