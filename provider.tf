terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.85.0"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.7.0"
    }
  }
  required_version = ">= 0.14"
}

provider "google" {
  # Configuration options
  project     = "poc-sandy-354205"
  region      = "us-central1"
  zone        = "us-central1-a"
  credentials = "keys.json"
}
provider "kubectl" {
  username = var.gke_username
  password = var.gke_password
  #token                  = data.aws_eks_cluster_auth.main.token
  #load_config_file       = false
}